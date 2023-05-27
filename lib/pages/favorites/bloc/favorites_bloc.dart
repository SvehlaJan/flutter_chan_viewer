import 'dart:collection';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_chan_viewer/bloc/chan_event.dart';
import 'package:flutter_chan_viewer/bloc/chan_state.dart';
import 'package:flutter_chan_viewer/locator.dart';
import 'package:flutter_chan_viewer/models/helper/online_state.dart';
import 'package:flutter_chan_viewer/models/thread_detail_model.dart';
import 'package:flutter_chan_viewer/models/ui/thread_item_vo.dart';
import 'package:flutter_chan_viewer/pages/base/base_bloc.dart';
import 'package:flutter_chan_viewer/pages/favorites/bloc/favorites_event.dart';
import 'package:flutter_chan_viewer/repositories/boards_repository.dart';
import 'package:flutter_chan_viewer/repositories/chan_repository.dart';
import 'package:flutter_chan_viewer/repositories/threads_repository.dart';
import 'package:flutter_chan_viewer/utils/chan_util.dart';
import 'package:flutter_chan_viewer/utils/exceptions.dart';
import 'package:flutter_chan_viewer/utils/extensions.dart';
import 'package:flutter_chan_viewer/utils/log_utils.dart';
import 'package:flutter_chan_viewer/utils/preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'favorites_state.dart';

class FavoritesBloc extends BaseBloc<ChanEvent, ChanState> {
  final logger = LogUtils.getLogger();
  final BoardsRepository _boardsRepository = getIt<BoardsRepository>();
  final ThreadsRepository _threadsRepository = getIt<ThreadsRepository>();
  final ChanRepository _repository = getIt<ChanRepository>();
  final Preferences _preferences = getIt<Preferences>();
  static const int DETAIL_REFRESH_TIMEOUT = 60 * 1000; // 60 seconds
  List<FavoritesThreadWrapper> _favoriteThreads = <FavoritesThreadWrapper>[];
  List<FavoritesThreadWrapper> _customThreads = <FavoritesThreadWrapper>[];
  int _lastDetailRefreshTimestamp = 0;

  FavoritesBloc() : super(ChanStateLoading()) {
    on<ChanEventFetchData>((event, emit) async {
      emit(ChanStateLoading());

      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      if (statuses.values.any((status) => status.isGranted == false)) {
        emit(ChanStateError("This feature requires permission to access storage"));
        return;
      }

      List<ThreadDetailModel> threads = await _threadsRepository.getFavoriteThreads();
      bool showNsfw = _preferences.getBool(Preferences.KEY_SETTINGS_SHOW_NSFW, def: false);
      if (!showNsfw) {
        List<String?> sfwBoardIds = (await _boardsRepository.fetchCachedBoardList(false))!.boards.map((board) => board.boardId).toList();
        threads.removeWhere((model) => !sfwBoardIds.contains(model.thread.boardId));
      }
      _favoriteThreads = threads.map((e) => FavoritesThreadWrapper(e.thread.toThreadItemVO())).toList();
      _customThreads = (await _threadsRepository.getCustomThreads())
          .map((thread) => FavoritesThreadWrapper(
                thread.toThreadItemVO(),
                isCustom: true,
              ))
          .toList();

      int currentTimestamp = ChanUtil.getNowTimestamp();
      bool shouldRefreshDetails = event.forceRefresh || currentTimestamp - _lastDetailRefreshTimestamp > DETAIL_REFRESH_TIMEOUT;
      if (_favoriteThreads.isNotEmpty && shouldRefreshDetails) {
        _lastDetailRefreshTimestamp = currentTimestamp;
        add(FavoritesEventFetchDetail(0));
      } else {
        emit(buildContentState());
      }
    });

    on<FavoritesEventFetchDetail>((event, emit) async {
      int refreshIndex = event.index;
      ThreadItemVO cachedThread = _favoriteThreads[refreshIndex].thread;
      ThreadDetailModel? refreshedThread;

      if ([OnlineState.ONLINE.index, OnlineState.UNKNOWN.index].contains(cachedThread.onlineStatus)) {
        _favoriteThreads[refreshIndex] = FavoritesThreadWrapper(cachedThread, isLoading: true);
        emit(buildContentState(lazyLoading: true));

        try {
          refreshedThread = await _threadsRepository.fetchRemoteThreadDetail(cachedThread.boardId, cachedThread.threadId, false);

          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.wifi) {
            _repository.downloadAllMedia(refreshedThread);
          }
        } on HttpException {
          logger.v("Thread not found. Probably offline. Ignoring");
        } on SocketException {
          emit(buildContentState(event: ChanSingleEvent.SHOW_OFFLINE));
        }
      } else {
        print("Favorite thread is already archived or dead. Not refreshing.");
      }

      _favoriteThreads[refreshIndex] = FavoritesThreadWrapper(refreshedThread?.thread.toThreadItemVO() ?? cachedThread);
      if (refreshIndex + 1 < _favoriteThreads.length) {
        emit(buildContentState(lazyLoading: true));
        add(FavoritesEventFetchDetail(refreshIndex + 1));
      } else {
        emit(buildContentState());
      }
    });
  }

  @override
  FavoritesStateContent buildContentState({bool lazyLoading = false, ChanSingleEvent? event}) {
    List<FavoritesItemWrapper> threads = [];
    List<FavoritesThreadWrapper> favoriteThreads;
    if (searchQuery.isNotEmpty) {
      List<FavoritesThreadWrapper> titleMatchThreads = _favoriteThreads.where((thread) {
        return (thread.thread.subtitle ?? "").containsIgnoreCase(searchQuery);
      }).toList();
      List<FavoritesThreadWrapper> bodyMatchThreads = _favoriteThreads.where((thread) {
        return (thread.thread.content ?? "").containsIgnoreCase(searchQuery);
      }).toList();
      favoriteThreads = LinkedHashSet<FavoritesThreadWrapper>.from(titleMatchThreads + bodyMatchThreads).toList();
    } else {
      favoriteThreads = _favoriteThreads;
    }
    if (favoriteThreads.isNotEmpty) {
      threads.add(FavoritesItemWrapper(true, null, "Threads"));
      threads.addAll(favoriteThreads.map((thread) => FavoritesItemWrapper(false, thread, null)));
    }

    List<FavoritesThreadWrapper> customThreads;
    if (searchQuery.isNotEmpty) {
      List<FavoritesThreadWrapper> titleMatchThreads = _customThreads.where((thread) {
        return (thread.thread.subtitle ?? "").containsIgnoreCase(searchQuery);
      }).toList();
      List<FavoritesThreadWrapper> bodyMatchThreads = _customThreads.where((thread) {
        return (thread.thread.content ?? "").containsIgnoreCase(searchQuery);
      }).toList();
      customThreads = LinkedHashSet<FavoritesThreadWrapper>.from(titleMatchThreads + bodyMatchThreads).toList();
    } else {
      customThreads = _customThreads;
    }
    if (customThreads.isNotEmpty) {
      threads.add(FavoritesItemWrapper(true, null, "Collections"));
      threads.addAll(customThreads.map((thread) => FavoritesItemWrapper(false, thread, null)));
    }

    return FavoritesStateContent(
      threads: threads,
      showLazyLoading: lazyLoading,
      event: event,
      showSearchBar: showSearchBar,
    );
  }
}
