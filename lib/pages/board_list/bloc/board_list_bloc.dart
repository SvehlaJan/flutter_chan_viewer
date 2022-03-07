import 'dart:io';

import 'package:flutter_chan_viewer/bloc/chan_event.dart';
import 'package:flutter_chan_viewer/bloc/chan_state.dart';
import 'package:flutter_chan_viewer/locator.dart';
import 'package:flutter_chan_viewer/models/board_list_model.dart';
import 'package:flutter_chan_viewer/models/helper/chan_board_item_wrapper.dart';
import 'package:flutter_chan_viewer/models/ui/board_item.dart';
import 'package:flutter_chan_viewer/pages/base/base_bloc.dart';
import 'package:flutter_chan_viewer/pages/board_list/bloc/board_list_state.dart';
import 'package:flutter_chan_viewer/repositories/chan_repository.dart';
import 'package:flutter_chan_viewer/utils/exceptions.dart';
import 'package:flutter_chan_viewer/utils/extensions.dart';
import 'package:flutter_chan_viewer/utils/preferences.dart';

class BoardListBloc extends BaseBloc<ChanEvent, ChanState> {
  final ChanRepository _repository = getIt<ChanRepository>();
  final Preferences _preferences = getIt<Preferences>();
  late List<BoardItem> favoriteBoards;
  late List<BoardItem> otherBoards;

  BoardListBloc() : super(ChanStateLoading()) {
    on<ChanEventFetchData>((event, emit) async {
      emit(ChanStateLoading());

      bool showNsfw = _preferences.getBool(Preferences.KEY_SETTINGS_SHOW_NSFW, def: false);
      List<String?> favoriteBoardIds = _preferences.getStringList(Preferences.KEY_FAVORITE_BOARDS);

      BoardListModel? boardListModel = await _repository.fetchCachedBoardList(showNsfw);
      if (boardListModel != null) {
        favoriteBoards = boardListModel.boards.where((board) => favoriteBoardIds.contains(board.boardId)).toList();
        otherBoards = boardListModel.boards.where((board) => !favoriteBoardIds.contains(board.boardId)).toList();
        emit(buildContentState(lazyLoading: true));
      }

      try {
        boardListModel = await _repository.fetchRemoteBoardList(showNsfw);
        favoriteBoards = boardListModel!.boards.where((board) => favoriteBoardIds.contains(board.boardId)).toList();
        otherBoards = boardListModel.boards.where((board) => !favoriteBoardIds.contains(board.boardId)).toList();
        emit(buildContentState(lazyLoading: false));
      } catch (e) {
        if (e is HttpException || e is SocketException) {
          emit(buildContentState(event: ChanSingleEvent.SHOW_OFFLINE));
        } else {
          rethrow;
        }
      }
    });
  }

  @override
  BoardListStateContent buildContentState({bool lazyLoading = false, ChanSingleEvent? event}) {
    List<ChanBoardItemWrapper> boards = [];
    List<ChanBoardItemWrapper> filteredFavoriteBoards = favoriteBoards
        .where((board) => _matchesQuery(board, searchQuery))
        .map((board) => ChanBoardItemWrapper(chanBoard: board))
        .toList();
    List<ChanBoardItemWrapper> filteredOtherBoards = otherBoards
        .where((board) => _matchesQuery(board, searchQuery))
        .map((board) => ChanBoardItemWrapper(chanBoard: board))
        .toList();
    if (filteredFavoriteBoards.isNotEmpty) {
      boards.add(ChanBoardItemWrapper(headerTitle: "Favorites"));
      boards.addAll(filteredFavoriteBoards);
      if (otherBoards.isNotEmpty) {
        boards.add(ChanBoardItemWrapper(headerTitle: "Others"));
      }
    }
    boards.addAll(filteredOtherBoards);

    return BoardListStateContent(
        boards: boards, showLazyLoading: lazyLoading, showSearchBar: showSearchBar, event: event);
  }

  bool _matchesQuery(BoardItem board, String query) {
    return board.boardId.containsIgnoreCase(query) || board.title.containsIgnoreCase(query);
  }
}
