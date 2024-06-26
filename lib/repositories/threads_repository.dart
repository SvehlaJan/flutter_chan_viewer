import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_chan_viewer/data/local/local_data_source.dart';
import 'package:flutter_chan_viewer/data/remote/remote_data_source.dart';
import 'package:flutter_chan_viewer/locator.dart';
import 'package:flutter_chan_viewer/models/helper/chan_post_base.dart';
import 'package:flutter_chan_viewer/models/helper/online_state.dart';
import 'package:flutter_chan_viewer/models/thread_detail_model.dart';
import 'package:flutter_chan_viewer/models/ui/post_item.dart';
import 'package:flutter_chan_viewer/models/ui/thread_item.dart';
import 'package:flutter_chan_viewer/repositories/chan_result.dart';
import 'package:flutter_chan_viewer/repositories/chan_storage.dart';
import 'package:flutter_chan_viewer/repositories/downloads_repository.dart';
import 'package:flutter_chan_viewer/utils/chan_util.dart';
import 'package:flutter_chan_viewer/utils/constants.dart';
import 'package:flutter_chan_viewer/utils/database_helper.dart';
import 'package:flutter_chan_viewer/utils/download_helper.dart';
import 'package:flutter_chan_viewer/utils/exceptions.dart';
import 'package:flutter_chan_viewer/utils/log_utils.dart';
import 'package:flutter_chan_viewer/utils/media_helper.dart';
import 'package:stream_transform/stream_transform.dart';

class ThreadsRepository with ChanLogger {
  final RemoteDataSource _chanApiProvider;
  final LocalDataSource _localDataSource;
  final ChanStorage _chanStorage;
  final DownloadsRepository _downloadsRepository;
  StreamSubscription? _downloadsSubscription;

  ThreadsRepository._(this._chanApiProvider, this._localDataSource, this._chanStorage, this._downloadsRepository) {
    _downloadsSubscription = _downloadsRepository.downloadsStream.listen((item) {
      final postId = int.tryParse(item.mediaId) ?? 0;
      final progress = item.progress == 100 ? ChanDownloadProgress.FINISHED : ChanDownloadProgress.IN_PROGRESS;
      logDebug("Download progress: $postId - $progress");
      _localDataSource.updatePostDownloadProgress(postId, progress.value);
    });
  }

  static Future<ThreadsRepository> create(
    RemoteDataSource chanApiProvider,
    LocalDataSource localDataSource,
    ChanStorage chanStorage,
    DownloadsRepository downloadsRepository,
  ) async {
    final repository = ThreadsRepository._(chanApiProvider, localDataSource, chanStorage, downloadsRepository);
    return repository;
  }

  Future<ThreadDetailModel> fetchRemoteThreadDetail(String boardId, int threadId, bool isArchived,
      {bool markAsSeen = false}) async {
    try {
      ThreadDetailModel model = await _chanApiProvider.fetchThreadDetail(boardId, threadId, isArchived);
      if (markAsSeen) {
        await _localDataSource.saveThread(model.thread.copyWith(lastSeenPostIndex: model.thread.replies));
      } else {
        await _localDataSource.saveThread(model.thread);
      }
      await _localDataSource.savePosts(model.allPosts);

      ThreadDetailModel? updatedModel = await fetchCachedThreadDetail(boardId, threadId);
      return updatedModel!;
    } catch (e) {
      if (e is HttpException && e.errorCode == 404) {
        await _localDataSource.updateThreadOnlineState(threadId, OnlineState.NOT_FOUND);
      }
      throw e;
    }
  }

  Future<ThreadDetailModel?> fetchCachedThreadDetail(String boardId, int threadId) async {
    ThreadItem? thread = await _localDataSource.getThreadById(boardId, threadId);
    if (thread != null) {
      List<PostItem> posts = await _localDataSource.getPostsFromThread(thread);
      return ThreadDetailModel.fromThreadAndPosts(thread, posts);
    }

    return null;
  }

  Stream<DataResult<ThreadDetailModel>> fetchAndObserveThreadDetail(String boardId, int threadId,
      [bool isArchived = false]) {
    StreamController<DataResult<ThreadDetailModel>> controller = StreamController.broadcast();
    _localDataSource.getThreadById(boardId, threadId).then((thread) async {
      _localDataSource.getPostsFromThread(thread!).then((posts) async {
        controller.add(DataResult.loading(ThreadDetailModel.fromThreadAndPosts(thread, posts)));
        try {
          await _chanApiProvider.fetchThreadDetail(boardId, threadId, isArchived).then((model) async {
            await _localDataSource.saveThread(model.thread);
            await _localDataSource.savePosts(model.allPosts);

            controller.addStream(_localDataSource.getThreadByIdStream(boardId, threadId).combineLatest(
                _localDataSource.getPostsByThreadIdStream(boardId, threadId),
                (thread, dynamic posts) => DataResult.success(ThreadDetailModel.fromThreadAndPosts(thread, posts))));
          });
        } catch (e) {
          if (e is HttpException && e.errorCode == 404) {
            await _localDataSource.updateThreadOnlineState(threadId, OnlineState.NOT_FOUND);
          }
          controller.add(DataResult.error(e as Exception));
        }
      });
    }).catchError((e) {
      controller.add(DataResult.error(e));
    });

    return controller.stream;
  }

  Stream<DataResult<ThreadDetailModel>> observeThreadDetail(String boardId, int threadId, [bool isArchived = false]) {
    return _localDataSource.getThreadByIdStream(boardId, threadId).combineLatest(
          _localDataSource.getPostsByThreadIdStream(boardId, threadId),
          (thread, dynamic posts) => DataResult.success(ThreadDetailModel.fromThreadAndPosts(
            thread,
            posts,
          )),
        );
  }

  Stream<DataResult<List<PostItem>>> observeThreadPosts(String boardId, int threadId) {
    return _localDataSource.getPostsByThreadIdStream(boardId, threadId).map((posts) => DataResult.success(posts));
  }

  Future<ThreadItem?> addThreadToFavorites(ThreadDetailModel model) async {
    await _localDataSource.updateThread(model.thread.copyWith(isThreadFavorite: true));

    await moveMediaToPermanentCache(model);
    unawaited(downloadAllMedia(model));
    return _localDataSource.getThreadById(model.thread.boardId, model.thread.threadId);
  }

  Future<ThreadItem?> removeThreadFromFavorites(ThreadDetailModel model) async {
    await _downloadsRepository.cancelMediaDownloads(
      model.allMediaPosts.map((post) => post.getMediaMetadata()).toList(),
    );

    // await moveMediaToTemporaryCache(model);
    await _chanStorage.deleteMediaDirectory(model.thread.cacheDirective);

    await _localDataSource.updateDownloadProgressByThreadId(
      model.thread.threadId,
      ChanDownloadProgress.NOT_STARTED.value,
    );
    await _localDataSource.updateThread(model.thread.copyWith(isThreadFavorite: false));
    return _localDataSource.getThreadById(model.thread.boardId, model.thread.threadId);
  }

  Future<ThreadItem?> updateThread(ThreadItem thread) async {
    await _localDataSource.updateThread(thread);
    return _localDataSource.getThreadById(thread.boardId, thread.threadId);
  }

  Future<List<ThreadItem>> getCustomThreads() async => await _localDataSource.getCustomThreads();

  Future<ThreadItem?> createCustomThread(String name) async {
    ThreadItem customThread = ThreadItem(
      threadId: DatabaseHelper.nextThreadId(),
      boardId: Constants.customBoardId,
      timestamp: ChanUtil.getNowTimestamp(),
      subtitle: name,
      onlineStatus: OnlineState.CUSTOM.index,
      isThreadFavorite: true,
    );

    await _localDataSource.saveThread(customThread);

    ThreadItem? newThread = await _localDataSource.getThreadById(customThread.boardId, customThread.threadId);
    return newThread;
  }

  Future<void> addPostToCustomThread(PostItem originalPost, int threadId) async {
    PostItem newPost = originalPost.copyWith(
      postId: DatabaseHelper.nextPostId(),
      threadId: threadId,
      boardId: Constants.customBoardId,
    );

    await _localDataSource.addPostToThread(newPost);
    _chanStorage.copyMediaFile(
      newPost.getMediaMetadata().getFileName(ChanPostMediaType.MAIN),
      originalPost.cacheDirective,
      newPost.cacheDirective,
    );

    return;
  }

  Future<void> deleteCustomThread(ThreadDetailModel model) async {
    await _chanStorage.deleteMediaDirectory(model.thread.cacheDirective);
    await _localDataSource.deleteThread(model.thread.boardId, model.thread.threadId);
  }

  Future<List<ThreadDetailModel>> getFavoriteThreads() async {
    List<ThreadItem> threads = await _localDataSource.getFavoriteThreads();
    List<ThreadDetailModel> models = threads.map((thread) => ThreadDetailModel.fromThreadAndPosts(thread, [])).toList();

    return models;
  }

  ///////////////////////////////////////////////////////////////////////

  Future<void> downloadAllMedia(ThreadDetailModel model) async {
    final List<MediaMetadata> mediaList = model.allMediaPosts.map((post) => post.getMediaMetadata()).toList();
    await _downloadsRepository.enqueueDownloads(mediaList);
  }

  Future<void> moveMediaToPermanentCache(ThreadDetailModel model) async {
    model.allMediaPosts.forEach((post) async {
      final mediaUrl = post.getMediaMetadata().getMediaUrl(ChanPostMediaType.MAIN);
      FileInfo? fileInfo = await getIt<CacheManager>().getFileFromCache(mediaUrl);
      if (fileInfo != null) {
        Uint8List fileData = await fileInfo.file.readAsBytes();
        await _chanStorage.writeMediaFile(
          post.getMediaMetadata().getFileName(ChanPostMediaType.MAIN),
          post.cacheDirective,
          fileData,
        );
      }
    });
  }
}
