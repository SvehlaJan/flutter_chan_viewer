import 'package:flutter_chan_viewer/data/local/dao/boards_dao.dart';
import 'package:flutter_chan_viewer/data/local/dao/posts_dao.dart';
import 'package:flutter_chan_viewer/data/local/dao/threads_dao.dart';
import 'package:flutter_chan_viewer/data/local/moor_db.dart';
import 'package:flutter_chan_viewer/locator.dart';
import 'package:flutter_chan_viewer/models/local/threads_table.dart';
import 'package:flutter_chan_viewer/models/ui/board_item.dart';
import 'package:flutter_chan_viewer/models/ui/thread_item.dart';
import 'package:flutter_chan_viewer/models/ui/post_item.dart';

class LocalDataSource {
  PostsDao _postsDao = getIt<PostsDao>();
  ThreadsDao _threadsDao = getIt<ThreadsDao>();
  BoardsDao _boardsDao = getIt<BoardsDao>();

  Future<void> savePosts(List<PostItem> posts) async {
    return _postsDao.insertPostsList(posts.map((post) => post.toTableData()).toList());
  }

  Future<List<PostItem>> getPostsByThread(ThreadItem thread) async {
    List<PostsTableData> posts = await _postsDao.getAllPostsFromThread(thread.boardId, thread.threadId);
    return posts.map((postData) => PostItem.fromTableData(postData, thread)).toList();
  }



  Future<void> saveThread(ThreadItem thread) async {
    return _threadsDao.insertThread(thread.toTableData());
  }

  Future<void> saveThreads(List<ThreadItem> threads) async {
    return _threadsDao.insertThreadsList(threads.map((thread) => thread.toTableData()).toList());
  }

  Future<ThreadItem> getThreadById(String boardId, int threadId) async {
    ThreadsTableData threadTableData = await _threadsDao.getThreadById(boardId, threadId);
    return threadTableData != null ? ThreadItem.fromTableData(threadTableData) : null;
  }

  Future<List<ThreadItem>> getThreadsByBoardIdAndOnlineState(String boardId, OnlineState onlineState) async {
    List<ThreadsTableData> threads = await _threadsDao.getAllThreadsByBoardIdAndOnlineState(boardId, onlineState);
    return threads.map((threadData) => ThreadItem.fromTableData(threadData)).toList();
  }

  /// Sets state to UNKNOWN of local threads which are no longer online
  Future<void> syncWithNewOnlineThreads(List<int> onlineThreadIds) async {
    List<ThreadsTableData> localThreads = await _threadsDao.getThreadsByOnlineState(OnlineState.ONLINE);
    List<ThreadsTableData> notFoundThreads = localThreads.where((thread) => !onlineThreadIds.contains(thread.threadId)).toList();
    await _threadsDao.updateThreadsOnlineState(notFoundThreads, OnlineState.UNKNOWN);

//    deleteRedundantUnknownThreads();

    return null;
  }

  Future<void> deleteRedundantUnknownThreads() async {
    List<ThreadsTableData> unknownThreads = await _threadsDao.getThreadsByOnlineState(OnlineState.UNKNOWN);
    unknownThreads.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    ThreadsTableData pivotingUnknownThread = unknownThreads.elementAt(200);
    if (pivotingUnknownThread != null) {
      _threadsDao.deleteThreadsWithOnlineStateOlderThan(OnlineState.UNKNOWN, pivotingUnknownThread.timestamp);
    }
  }

  /// Deletes old archived threads, which are no login in archive.
  Future<void> syncWithNewArchivedThreads(List<int> archivedThreadIds) async {
    List<ThreadsTableData> localThreads = await _threadsDao.getThreadsByOnlineState(OnlineState.ARCHIVED);
    List<ThreadsTableData> notFoundThreads = localThreads.where((thread) => !archivedThreadIds.contains(thread.threadId) & !thread.isFavorite).toList();
    List<int> notFoundThreadIds = notFoundThreads.map((thread) => thread.threadId).toList();
    await _threadsDao.deleteThreadsByIds(notFoundThreadIds);
    return null;
  }

  Future<BoardItem> getBoardById(String boardId) async {
    BoardsTableData boardTableData = await _boardsDao.getBoardById(boardId);
    return boardTableData != null ? BoardItem.fromTableData(boardTableData) : null;
  }

  Future<List<BoardItem>> getBoards(bool includeNsfw) async {
    List<BoardsTableData> boards = await _boardsDao.getBoardItems(includeNsfw);
    return boards.map((boardData) => BoardItem.fromTableData(boardData)).toList();
  }

  Future<void> saveBoards(List<BoardItem> boards) async {
    return _boardsDao.insertBoardsList(boards.map((post) => post.toTableData()).toList());
  }
}
