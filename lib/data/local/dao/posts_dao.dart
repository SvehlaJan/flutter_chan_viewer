import 'package:drift/drift.dart';
import 'package:flutter_chan_viewer/data/local/moor_db.dart';
import 'package:flutter_chan_viewer/data/local/tables/posts_table.dart';

part 'posts_dao.g.dart';

@DriftAccessor(tables: [PostsTable])
class PostsDao extends DatabaseAccessor<ChanDB> with _$PostsDaoMixin {
  PostsDao(ChanDB db) : super(db);

  Future<PostsTableData?> getPostById(int postId, int threadId, String boardId) => (select(postsTable)
        ..where((post) => post.postId.equals(postId) & post.threadId.equals(threadId) & post.boardId.equals(boardId)))
      .getSingleOrNull();

  Future<List<PostsTableData>> getAllPostsFromThread(String boardId, int threadId) =>
      (select(postsTable)..where((post) => post.threadId.equals(threadId) & post.boardId.equals(boardId))).get();

  Stream<List<PostsTableData>> getAllPostsFromThreadStream(String boardId, int threadId) =>
      (select(postsTable)..where((post) => post.threadId.equals(threadId) & post.boardId.equals(boardId))).watch();

  Future<int> insertPost(PostsTableData entry) {
    return into(postsTable).insert(
      entry,
      mode: InsertMode.insertOrReplace,
      onConflict: DoUpdate(
        (old) {
          return PostsTableCompanion.custom(isHidden: old.isHidden);
        },
        target: [postsTable.boardId, postsTable.threadId, postsTable.postId],
      ),
    );
  }

  Future<void> insertPostsList(List<PostsTableData> entries) async {
    await batch(
      (batch) {
        batch.insertAll(
          postsTable,
          entries,
          onConflict: DoUpdate(
            (dynamic old) {
              return PostsTableCompanion.custom(isHidden: old.isHidden, downloadProgress: old.downloadProgress);
            },
            target: [postsTable.boardId, postsTable.threadId, postsTable.postId],
          ),
        );
      },
    );
  }

  Future<bool> updatePost(PostsTableData entry) {
    return (update(postsTable).replace(entry)).then((value) {
      return value;
    });
  }

  Future<int> updateDownloadProgress(int postId, int downloadProgress) {
    return (update(postsTable)..where((post) => post.postId.equals(postId))).write(
      PostsTableCompanion(downloadProgress: Value(downloadProgress)),
    );
  }

  Future<int> updateDownloadProgressByThreadId(int threadId, int downloadProgress) {
    return (update(postsTable)..where((post) => post.threadId.equals(threadId))).write(
      PostsTableCompanion(downloadProgress: Value(downloadProgress)),
    );
  }

  Future<int> deletePostById(int postId, String boardId) =>
      (delete(postsTable)..where((post) => post.postId.equals(postId) & post.boardId.equals(boardId)))
          .go()
          .then((value) {
        return value;
      });
}
