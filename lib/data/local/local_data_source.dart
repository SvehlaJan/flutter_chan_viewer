import 'package:flutter_chan_viewer/data/local/dao/boards_dao.dart';
import 'package:flutter_chan_viewer/data/local/dao/posts_dao.dart';
import 'package:flutter_chan_viewer/data/local/dao/threads_dao.dart';
import 'package:flutter_chan_viewer/data/local/moor_db.dart';
import 'package:flutter_chan_viewer/locator.dart';
import 'package:flutter_chan_viewer/models/helper/online_state.dart';
import 'package:flutter_chan_viewer/models/ui/board_item.dart';
import 'package:flutter_chan_viewer/models/ui/post_item.dart';
import 'package:flutter_chan_viewer/models/ui/thread_item.dart';

class LocalDataSource {
  PostsDao _postsDao = getIt<PostsDao>();
  ThreadsDao _threadsDao = getIt<ThreadsDao>();
  BoardsDao _boardsDao = getIt<BoardsDao>();

  Future<void> savePosts(List<PostItem> posts) async {
    return _postsDao.insertPostsList(posts.map((post) => post.toTableData()).toList());
  }

  Future<bool> updatePost(PostItem post) async {
    return _postsDao.updatePost(post.toTableData());
  }

  Future<int> updatePostDownloadProgress(int postId, int downloadProgress) {
    return _postsDao.updateDownloadProgress(postId, downloadProgress);
  }

  Future<List<PostItem>> getPostsFromThread(ThreadItem thread) async {
    List<PostsTableData> posts = await _postsDao.getAllPostsFromThread(thread.boardId, thread.threadId);
    return posts.map((postData) => PostItem.fromTableData(postData, thread: thread)).toList();
  }

  Stream<List<PostItem>> getPostsByThreadIdStream(String boardId, int threadId) {
    return _postsDao
        .getAllPostsFromThreadStream(boardId, threadId)
        .map((posts) => posts.map((postData) => PostItem.fromTableData(postData)).toList());
  }

  Future<void> saveThread(ThreadItem thread) async {
    return _threadsDao.insertThread(thread.toTableData());
  }

  Future<void> saveThreads(List<ThreadItem> threads) async {
    return _threadsDao.insertThreadsList(threads.map((thread) => thread.toTableData()).toList());
  }

  Future<bool> updateThread(ThreadItem thread) async {
    return _threadsDao.updateThread(thread.toTableData());
  }

  Future<void> updateThreadOnlineState(int threadId, OnlineState onlineState) async {
    return _threadsDao.updateThreadOnlineState(threadId, onlineState);
  }

  Future<int> updateDownloadProgressByThreadId(int threadId, int downloadProgress) async {
    return _postsDao.updateDownloadProgressByThreadId(threadId, downloadProgress);
  }

  Future<ThreadItem?> getThreadById(String boardId, int threadId) async {
    ThreadsTableData? threadTableData = await _threadsDao.getThreadById(boardId, threadId);
    return threadTableData != null ? ThreadItem.fromTableData(threadTableData) : null;
  }

  Future<List<ThreadItem>> getThreadsByBoardId(String boardId) async {
    List<ThreadsTableData> threads = await _threadsDao.getThreadsByBoardId(boardId);
    return threads.map((threadData) => ThreadItem.fromTableData(threadData)).toList();
  }

  Stream<ThreadItem> getThreadByIdStream(String boardId, int threadId) {
    return _threadsDao.getThreadStreamById(boardId, threadId).map((threadData) => ThreadItem.fromTableData(threadData));
  }

  Future<List<ThreadItem>> getFavoriteThreads() async {
    List<ThreadsTableData> threads = await _threadsDao.getFavoriteThreads();
    return threads.map((threadData) => ThreadItem.fromTableData(threadData)).toList();
  }

  Future<List<ThreadItem>> getCustomThreads() async {
    List<ThreadsTableData> threads = await _threadsDao.getCustomThreads();
    return threads.map((threadData) => ThreadItem.fromTableData(threadData)).toList();
  }

  Future<List<ThreadItem>> getArchivedThreads() async {
    List<ThreadsTableData> threads = await _threadsDao.getArchivedThreads();
    return threads.map((threadData) => ThreadItem.fromTableData(threadData)).toList();
  }

  Future<List<ThreadItem>> getThreadsByBoardIdAndOnlineState(String boardId, OnlineState onlineState) async {
    List<ThreadsTableData> threadsTableData = await _threadsDao.getThreadsByBoardIdAndOnlineState(boardId, onlineState);
    List<ThreadItem> threads = threadsTableData.map((threadData) => ThreadItem.fromTableData(threadData)).toList();
    return threads;
  }

  Stream<List<ThreadItem>> getThreadsByBoardIdAndOnlineStateStream(String boardId, OnlineState onlineState) {
    return _threadsDao
        .getThreadsStreamByBoardIdAndOnlineState(boardId, onlineState)
        .map((threadsTableData) => threadsTableData.map((threadData) => ThreadItem.fromTableData(threadData)).toList());
  }

  /// Sets state to UNKNOWN of tables threads which are no longer online
  Future<void> syncWithNewOnlineThreads(String boardId, List<int> onlineThreadIds) async {
    List<ThreadsTableData> localThreads =
        await _threadsDao.getThreadsByBoardIdAndOnlineState(boardId, OnlineState.ONLINE);
    List<ThreadsTableData> notFoundThreads =
        localThreads.where((thread) => !onlineThreadIds.contains(thread.threadId)).toList();
    await _threadsDao.updateThreadsOnlineState(notFoundThreads, OnlineState.UNKNOWN);

//    deleteRedundantUnknownThreads();

    return null;
  }

  Future<void> deleteRedundantUnknownThreads(String boardId) async {
    List<ThreadsTableData> unknownThreads =
        await _threadsDao.getThreadsByBoardIdAndOnlineState(boardId, OnlineState.UNKNOWN);
    if (unknownThreads.length > 200) {
      unknownThreads.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
      ThreadsTableData pivotingUnknownThread = unknownThreads.elementAt(200);
      int? timestamp = pivotingUnknownThread.timestamp;
      if (timestamp != null) {
        _threadsDao.deleteThreadsWithOnlineStateOlderThan(OnlineState.UNKNOWN, timestamp);
      }
    }
  }

  /// Deletes old archived threads, which are no login in archive.
  Future<void> syncWithNewArchivedThreads(String boardId, List<int> archivedThreadIds) async {
    List<ThreadsTableData> localArchivedThreads =
        await _threadsDao.getThreadsByBoardIdAndOnlineState(boardId, OnlineState.ARCHIVED);
    List<ThreadsTableData> notFoundThreads = localArchivedThreads
        .where((thread) => !archivedThreadIds.contains(thread.threadId) & !thread.isFavorite!)
        .toList();
    List<int> notFoundThreadIds = notFoundThreads.map((thread) => thread.threadId).toList();
    await _threadsDao.deleteThreadsByIds(notFoundThreadIds);

    List<ThreadsTableData> localOnlineThreads =
        await _threadsDao.getThreadsByBoardIdAndOnlineState(boardId, OnlineState.ONLINE);
    List<ThreadsTableData> newArchivedThreads =
        localOnlineThreads.where((thread) => archivedThreadIds.contains(thread.threadId)).toList();
    await _threadsDao.updateThreadsOnlineState(newArchivedThreads, OnlineState.ARCHIVED);
    return null;
  }

  Future<void> addPostToThread(PostItem post) async {
    await _postsDao.insertPost(post.toTableData());
    return;
  }

  Future<void> deleteThread(String boardId, int threadId) async {
    await _threadsDao.deleteThreadById(boardId, threadId);
  }

  Future<List<BoardItem>> getBoards(bool includeNsfw) async {
    List<BoardsTableData> boards = await _boardsDao.getAllBoards(includeNsfw);
    return boards.map((boardData) => BoardItem.fromTableData(boardData)).toList();
  }

  Stream<List<BoardItem>> getBoardsStream(bool includeNsfw) {
    return _boardsDao
        .getAllBoardsStream(includeNsfw)
        .map((boards) => boards.map((boardData) => BoardItem.fromTableData(boardData)).toList());
  }

  Future<void> saveBoards(List<BoardItem> boards) async {
    return _boardsDao.insertBoardsList(boards.map((post) => post.toTableData()).toList());
  }
}
