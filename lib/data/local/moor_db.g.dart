// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PostsTableData extends DataClass implements Insertable<PostsTableData> {
  final String boardId;
  final int threadId;
  final int timestamp;
  final String subtitle;
  final String content;
  final String filename;
  final String imageId;
  final String extension;
  final int postId;
  PostsTableData(
      {@required this.boardId,
      @required this.threadId,
      @required this.timestamp,
      this.subtitle,
      this.content,
      this.filename,
      this.imageId,
      this.extension,
      @required this.postId});
  factory PostsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return PostsTableData(
      boardId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}board_id']),
      threadId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}thread_id']),
      timestamp:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      subtitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}subtitle']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      filename: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}filename']),
      imageId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_id']),
      extension: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}extension']),
      postId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}post_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || boardId != null) {
      map['board_id'] = Variable<String>(boardId);
    }
    if (!nullToAbsent || threadId != null) {
      map['thread_id'] = Variable<int>(threadId);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || filename != null) {
      map['filename'] = Variable<String>(filename);
    }
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    if (!nullToAbsent || extension != null) {
      map['extension'] = Variable<String>(extension);
    }
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<int>(postId);
    }
    return map;
  }

  PostsTableCompanion toCompanion(bool nullToAbsent) {
    return PostsTableCompanion(
      boardId: boardId == null && nullToAbsent
          ? const Value.absent()
          : Value(boardId),
      threadId: threadId == null && nullToAbsent
          ? const Value.absent()
          : Value(threadId),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      filename: filename == null && nullToAbsent
          ? const Value.absent()
          : Value(filename),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      extension: extension == null && nullToAbsent
          ? const Value.absent()
          : Value(extension),
      postId:
          postId == null && nullToAbsent ? const Value.absent() : Value(postId),
    );
  }

  factory PostsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PostsTableData(
      boardId: serializer.fromJson<String>(json['boardId']),
      threadId: serializer.fromJson<int>(json['threadId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      content: serializer.fromJson<String>(json['content']),
      filename: serializer.fromJson<String>(json['filename']),
      imageId: serializer.fromJson<String>(json['imageId']),
      extension: serializer.fromJson<String>(json['extension']),
      postId: serializer.fromJson<int>(json['postId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'boardId': serializer.toJson<String>(boardId),
      'threadId': serializer.toJson<int>(threadId),
      'timestamp': serializer.toJson<int>(timestamp),
      'subtitle': serializer.toJson<String>(subtitle),
      'content': serializer.toJson<String>(content),
      'filename': serializer.toJson<String>(filename),
      'imageId': serializer.toJson<String>(imageId),
      'extension': serializer.toJson<String>(extension),
      'postId': serializer.toJson<int>(postId),
    };
  }

  PostsTableData copyWith(
          {String boardId,
          int threadId,
          int timestamp,
          String subtitle,
          String content,
          String filename,
          String imageId,
          String extension,
          int postId}) =>
      PostsTableData(
        boardId: boardId ?? this.boardId,
        threadId: threadId ?? this.threadId,
        timestamp: timestamp ?? this.timestamp,
        subtitle: subtitle ?? this.subtitle,
        content: content ?? this.content,
        filename: filename ?? this.filename,
        imageId: imageId ?? this.imageId,
        extension: extension ?? this.extension,
        postId: postId ?? this.postId,
      );
  @override
  String toString() {
    return (StringBuffer('PostsTableData(')
          ..write('boardId: $boardId, ')
          ..write('threadId: $threadId, ')
          ..write('timestamp: $timestamp, ')
          ..write('subtitle: $subtitle, ')
          ..write('content: $content, ')
          ..write('filename: $filename, ')
          ..write('imageId: $imageId, ')
          ..write('extension: $extension, ')
          ..write('postId: $postId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      boardId.hashCode,
      $mrjc(
          threadId.hashCode,
          $mrjc(
              timestamp.hashCode,
              $mrjc(
                  subtitle.hashCode,
                  $mrjc(
                      content.hashCode,
                      $mrjc(
                          filename.hashCode,
                          $mrjc(
                              imageId.hashCode,
                              $mrjc(
                                  extension.hashCode, postId.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PostsTableData &&
          other.boardId == this.boardId &&
          other.threadId == this.threadId &&
          other.timestamp == this.timestamp &&
          other.subtitle == this.subtitle &&
          other.content == this.content &&
          other.filename == this.filename &&
          other.imageId == this.imageId &&
          other.extension == this.extension &&
          other.postId == this.postId);
}

class PostsTableCompanion extends UpdateCompanion<PostsTableData> {
  final Value<String> boardId;
  final Value<int> threadId;
  final Value<int> timestamp;
  final Value<String> subtitle;
  final Value<String> content;
  final Value<String> filename;
  final Value<String> imageId;
  final Value<String> extension;
  final Value<int> postId;
  const PostsTableCompanion({
    this.boardId = const Value.absent(),
    this.threadId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.content = const Value.absent(),
    this.filename = const Value.absent(),
    this.imageId = const Value.absent(),
    this.extension = const Value.absent(),
    this.postId = const Value.absent(),
  });
  PostsTableCompanion.insert({
    @required String boardId,
    @required int threadId,
    @required int timestamp,
    this.subtitle = const Value.absent(),
    this.content = const Value.absent(),
    this.filename = const Value.absent(),
    this.imageId = const Value.absent(),
    this.extension = const Value.absent(),
    @required int postId,
  })  : boardId = Value(boardId),
        threadId = Value(threadId),
        timestamp = Value(timestamp),
        postId = Value(postId);
  static Insertable<PostsTableData> custom({
    Expression<String> boardId,
    Expression<int> threadId,
    Expression<int> timestamp,
    Expression<String> subtitle,
    Expression<String> content,
    Expression<String> filename,
    Expression<String> imageId,
    Expression<String> extension,
    Expression<int> postId,
  }) {
    return RawValuesInsertable({
      if (boardId != null) 'board_id': boardId,
      if (threadId != null) 'thread_id': threadId,
      if (timestamp != null) 'timestamp': timestamp,
      if (subtitle != null) 'subtitle': subtitle,
      if (content != null) 'content': content,
      if (filename != null) 'filename': filename,
      if (imageId != null) 'image_id': imageId,
      if (extension != null) 'extension': extension,
      if (postId != null) 'post_id': postId,
    });
  }

  PostsTableCompanion copyWith(
      {Value<String> boardId,
      Value<int> threadId,
      Value<int> timestamp,
      Value<String> subtitle,
      Value<String> content,
      Value<String> filename,
      Value<String> imageId,
      Value<String> extension,
      Value<int> postId}) {
    return PostsTableCompanion(
      boardId: boardId ?? this.boardId,
      threadId: threadId ?? this.threadId,
      timestamp: timestamp ?? this.timestamp,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      filename: filename ?? this.filename,
      imageId: imageId ?? this.imageId,
      extension: extension ?? this.extension,
      postId: postId ?? this.postId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<int>(threadId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<int>(postId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsTableCompanion(')
          ..write('boardId: $boardId, ')
          ..write('threadId: $threadId, ')
          ..write('timestamp: $timestamp, ')
          ..write('subtitle: $subtitle, ')
          ..write('content: $content, ')
          ..write('filename: $filename, ')
          ..write('imageId: $imageId, ')
          ..write('extension: $extension, ')
          ..write('postId: $postId')
          ..write(')'))
        .toString();
  }
}

class $PostsTableTable extends PostsTable
    with TableInfo<$PostsTableTable, PostsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PostsTableTable(this._db, [this._alias]);
  final VerificationMeta _boardIdMeta = const VerificationMeta('boardId');
  GeneratedTextColumn _boardId;
  @override
  GeneratedTextColumn get boardId => _boardId ??= _constructBoardId();
  GeneratedTextColumn _constructBoardId() {
    return GeneratedTextColumn(
      'board_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _threadIdMeta = const VerificationMeta('threadId');
  GeneratedIntColumn _threadId;
  @override
  GeneratedIntColumn get threadId => _threadId ??= _constructThreadId();
  GeneratedIntColumn _constructThreadId() {
    return GeneratedIntColumn(
      'thread_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedIntColumn _timestamp;
  @override
  GeneratedIntColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedIntColumn _constructTimestamp() {
    return GeneratedIntColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subtitleMeta = const VerificationMeta('subtitle');
  GeneratedTextColumn _subtitle;
  @override
  GeneratedTextColumn get subtitle => _subtitle ??= _constructSubtitle();
  GeneratedTextColumn _constructSubtitle() {
    return GeneratedTextColumn(
      'subtitle',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      true,
    );
  }

  final VerificationMeta _filenameMeta = const VerificationMeta('filename');
  GeneratedTextColumn _filename;
  @override
  GeneratedTextColumn get filename => _filename ??= _constructFilename();
  GeneratedTextColumn _constructFilename() {
    return GeneratedTextColumn(
      'filename',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageIdMeta = const VerificationMeta('imageId');
  GeneratedTextColumn _imageId;
  @override
  GeneratedTextColumn get imageId => _imageId ??= _constructImageId();
  GeneratedTextColumn _constructImageId() {
    return GeneratedTextColumn(
      'image_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _extensionMeta = const VerificationMeta('extension');
  GeneratedTextColumn _extension;
  @override
  GeneratedTextColumn get extension => _extension ??= _constructExtension();
  GeneratedTextColumn _constructExtension() {
    return GeneratedTextColumn(
      'extension',
      $tableName,
      true,
    );
  }

  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  GeneratedIntColumn _postId;
  @override
  GeneratedIntColumn get postId => _postId ??= _constructPostId();
  GeneratedIntColumn _constructPostId() {
    return GeneratedIntColumn(
      'post_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        boardId,
        threadId,
        timestamp,
        subtitle,
        content,
        filename,
        imageId,
        extension,
        postId
      ];
  @override
  $PostsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'posts_table';
  @override
  final String actualTableName = 'posts_table';
  @override
  VerificationContext validateIntegrity(Insertable<PostsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id'], _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(_threadIdMeta,
          threadId.isAcceptableOrUnknown(data['thread_id'], _threadIdMeta));
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle'], _subtitleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename'], _filenameMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id'], _imageIdMeta));
    }
    if (data.containsKey('extension')) {
      context.handle(_extensionMeta,
          extension.isAcceptableOrUnknown(data['extension'], _extensionMeta));
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id'], _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {postId, threadId, boardId};
  @override
  PostsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PostsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PostsTableTable createAlias(String alias) {
    return $PostsTableTable(_db, alias);
  }
}

class ThreadsTableData extends DataClass
    implements Insertable<ThreadsTableData> {
  final String boardId;
  final int threadId;
  final int timestamp;
  final String subtitle;
  final String content;
  final String filename;
  final String imageId;
  final String extension;
  final bool isFavorite;
  final OnlineState onlineState;
  final int replyCount;
  final int imageCount;
  ThreadsTableData(
      {@required this.boardId,
      @required this.threadId,
      @required this.timestamp,
      this.subtitle,
      this.content,
      this.filename,
      this.imageId,
      this.extension,
      @required this.isFavorite,
      @required this.onlineState,
      @required this.replyCount,
      @required this.imageCount});
  factory ThreadsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ThreadsTableData(
      boardId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}board_id']),
      threadId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}thread_id']),
      timestamp:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      subtitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}subtitle']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      filename: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}filename']),
      imageId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_id']),
      extension: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}extension']),
      isFavorite: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favorite']),
      onlineState: $ThreadsTableTable.$converter0.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}online_state'])),
      replyCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}reply_count']),
      imageCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_count']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || boardId != null) {
      map['board_id'] = Variable<String>(boardId);
    }
    if (!nullToAbsent || threadId != null) {
      map['thread_id'] = Variable<int>(threadId);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || filename != null) {
      map['filename'] = Variable<String>(filename);
    }
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    if (!nullToAbsent || extension != null) {
      map['extension'] = Variable<String>(extension);
    }
    if (!nullToAbsent || isFavorite != null) {
      map['is_favorite'] = Variable<bool>(isFavorite);
    }
    if (!nullToAbsent || onlineState != null) {
      final converter = $ThreadsTableTable.$converter0;
      map['online_state'] = Variable<int>(converter.mapToSql(onlineState));
    }
    if (!nullToAbsent || replyCount != null) {
      map['reply_count'] = Variable<int>(replyCount);
    }
    if (!nullToAbsent || imageCount != null) {
      map['image_count'] = Variable<int>(imageCount);
    }
    return map;
  }

  ThreadsTableCompanion toCompanion(bool nullToAbsent) {
    return ThreadsTableCompanion(
      boardId: boardId == null && nullToAbsent
          ? const Value.absent()
          : Value(boardId),
      threadId: threadId == null && nullToAbsent
          ? const Value.absent()
          : Value(threadId),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      filename: filename == null && nullToAbsent
          ? const Value.absent()
          : Value(filename),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      extension: extension == null && nullToAbsent
          ? const Value.absent()
          : Value(extension),
      isFavorite: isFavorite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavorite),
      onlineState: onlineState == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineState),
      replyCount: replyCount == null && nullToAbsent
          ? const Value.absent()
          : Value(replyCount),
      imageCount: imageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(imageCount),
    );
  }

  factory ThreadsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ThreadsTableData(
      boardId: serializer.fromJson<String>(json['boardId']),
      threadId: serializer.fromJson<int>(json['threadId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      content: serializer.fromJson<String>(json['content']),
      filename: serializer.fromJson<String>(json['filename']),
      imageId: serializer.fromJson<String>(json['imageId']),
      extension: serializer.fromJson<String>(json['extension']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      onlineState: serializer.fromJson<OnlineState>(json['onlineState']),
      replyCount: serializer.fromJson<int>(json['replyCount']),
      imageCount: serializer.fromJson<int>(json['imageCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'boardId': serializer.toJson<String>(boardId),
      'threadId': serializer.toJson<int>(threadId),
      'timestamp': serializer.toJson<int>(timestamp),
      'subtitle': serializer.toJson<String>(subtitle),
      'content': serializer.toJson<String>(content),
      'filename': serializer.toJson<String>(filename),
      'imageId': serializer.toJson<String>(imageId),
      'extension': serializer.toJson<String>(extension),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'onlineState': serializer.toJson<OnlineState>(onlineState),
      'replyCount': serializer.toJson<int>(replyCount),
      'imageCount': serializer.toJson<int>(imageCount),
    };
  }

  ThreadsTableData copyWith(
          {String boardId,
          int threadId,
          int timestamp,
          String subtitle,
          String content,
          String filename,
          String imageId,
          String extension,
          bool isFavorite,
          OnlineState onlineState,
          int replyCount,
          int imageCount}) =>
      ThreadsTableData(
        boardId: boardId ?? this.boardId,
        threadId: threadId ?? this.threadId,
        timestamp: timestamp ?? this.timestamp,
        subtitle: subtitle ?? this.subtitle,
        content: content ?? this.content,
        filename: filename ?? this.filename,
        imageId: imageId ?? this.imageId,
        extension: extension ?? this.extension,
        isFavorite: isFavorite ?? this.isFavorite,
        onlineState: onlineState ?? this.onlineState,
        replyCount: replyCount ?? this.replyCount,
        imageCount: imageCount ?? this.imageCount,
      );
  @override
  String toString() {
    return (StringBuffer('ThreadsTableData(')
          ..write('boardId: $boardId, ')
          ..write('threadId: $threadId, ')
          ..write('timestamp: $timestamp, ')
          ..write('subtitle: $subtitle, ')
          ..write('content: $content, ')
          ..write('filename: $filename, ')
          ..write('imageId: $imageId, ')
          ..write('extension: $extension, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('onlineState: $onlineState, ')
          ..write('replyCount: $replyCount, ')
          ..write('imageCount: $imageCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      boardId.hashCode,
      $mrjc(
          threadId.hashCode,
          $mrjc(
              timestamp.hashCode,
              $mrjc(
                  subtitle.hashCode,
                  $mrjc(
                      content.hashCode,
                      $mrjc(
                          filename.hashCode,
                          $mrjc(
                              imageId.hashCode,
                              $mrjc(
                                  extension.hashCode,
                                  $mrjc(
                                      isFavorite.hashCode,
                                      $mrjc(
                                          onlineState.hashCode,
                                          $mrjc(replyCount.hashCode,
                                              imageCount.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ThreadsTableData &&
          other.boardId == this.boardId &&
          other.threadId == this.threadId &&
          other.timestamp == this.timestamp &&
          other.subtitle == this.subtitle &&
          other.content == this.content &&
          other.filename == this.filename &&
          other.imageId == this.imageId &&
          other.extension == this.extension &&
          other.isFavorite == this.isFavorite &&
          other.onlineState == this.onlineState &&
          other.replyCount == this.replyCount &&
          other.imageCount == this.imageCount);
}

class ThreadsTableCompanion extends UpdateCompanion<ThreadsTableData> {
  final Value<String> boardId;
  final Value<int> threadId;
  final Value<int> timestamp;
  final Value<String> subtitle;
  final Value<String> content;
  final Value<String> filename;
  final Value<String> imageId;
  final Value<String> extension;
  final Value<bool> isFavorite;
  final Value<OnlineState> onlineState;
  final Value<int> replyCount;
  final Value<int> imageCount;
  const ThreadsTableCompanion({
    this.boardId = const Value.absent(),
    this.threadId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.content = const Value.absent(),
    this.filename = const Value.absent(),
    this.imageId = const Value.absent(),
    this.extension = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.onlineState = const Value.absent(),
    this.replyCount = const Value.absent(),
    this.imageCount = const Value.absent(),
  });
  ThreadsTableCompanion.insert({
    @required String boardId,
    @required int threadId,
    @required int timestamp,
    this.subtitle = const Value.absent(),
    this.content = const Value.absent(),
    this.filename = const Value.absent(),
    this.imageId = const Value.absent(),
    this.extension = const Value.absent(),
    @required bool isFavorite,
    @required OnlineState onlineState,
    @required int replyCount,
    @required int imageCount,
  })  : boardId = Value(boardId),
        threadId = Value(threadId),
        timestamp = Value(timestamp),
        isFavorite = Value(isFavorite),
        onlineState = Value(onlineState),
        replyCount = Value(replyCount),
        imageCount = Value(imageCount);
  static Insertable<ThreadsTableData> custom({
    Expression<String> boardId,
    Expression<int> threadId,
    Expression<int> timestamp,
    Expression<String> subtitle,
    Expression<String> content,
    Expression<String> filename,
    Expression<String> imageId,
    Expression<String> extension,
    Expression<bool> isFavorite,
    Expression<int> onlineState,
    Expression<int> replyCount,
    Expression<int> imageCount,
  }) {
    return RawValuesInsertable({
      if (boardId != null) 'board_id': boardId,
      if (threadId != null) 'thread_id': threadId,
      if (timestamp != null) 'timestamp': timestamp,
      if (subtitle != null) 'subtitle': subtitle,
      if (content != null) 'content': content,
      if (filename != null) 'filename': filename,
      if (imageId != null) 'image_id': imageId,
      if (extension != null) 'extension': extension,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (onlineState != null) 'online_state': onlineState,
      if (replyCount != null) 'reply_count': replyCount,
      if (imageCount != null) 'image_count': imageCount,
    });
  }

  ThreadsTableCompanion copyWith(
      {Value<String> boardId,
      Value<int> threadId,
      Value<int> timestamp,
      Value<String> subtitle,
      Value<String> content,
      Value<String> filename,
      Value<String> imageId,
      Value<String> extension,
      Value<bool> isFavorite,
      Value<OnlineState> onlineState,
      Value<int> replyCount,
      Value<int> imageCount}) {
    return ThreadsTableCompanion(
      boardId: boardId ?? this.boardId,
      threadId: threadId ?? this.threadId,
      timestamp: timestamp ?? this.timestamp,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      filename: filename ?? this.filename,
      imageId: imageId ?? this.imageId,
      extension: extension ?? this.extension,
      isFavorite: isFavorite ?? this.isFavorite,
      onlineState: onlineState ?? this.onlineState,
      replyCount: replyCount ?? this.replyCount,
      imageCount: imageCount ?? this.imageCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<int>(threadId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (onlineState.present) {
      final converter = $ThreadsTableTable.$converter0;
      map['online_state'] =
          Variable<int>(converter.mapToSql(onlineState.value));
    }
    if (replyCount.present) {
      map['reply_count'] = Variable<int>(replyCount.value);
    }
    if (imageCount.present) {
      map['image_count'] = Variable<int>(imageCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThreadsTableCompanion(')
          ..write('boardId: $boardId, ')
          ..write('threadId: $threadId, ')
          ..write('timestamp: $timestamp, ')
          ..write('subtitle: $subtitle, ')
          ..write('content: $content, ')
          ..write('filename: $filename, ')
          ..write('imageId: $imageId, ')
          ..write('extension: $extension, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('onlineState: $onlineState, ')
          ..write('replyCount: $replyCount, ')
          ..write('imageCount: $imageCount')
          ..write(')'))
        .toString();
  }
}

class $ThreadsTableTable extends ThreadsTable
    with TableInfo<$ThreadsTableTable, ThreadsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ThreadsTableTable(this._db, [this._alias]);
  final VerificationMeta _boardIdMeta = const VerificationMeta('boardId');
  GeneratedTextColumn _boardId;
  @override
  GeneratedTextColumn get boardId => _boardId ??= _constructBoardId();
  GeneratedTextColumn _constructBoardId() {
    return GeneratedTextColumn(
      'board_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _threadIdMeta = const VerificationMeta('threadId');
  GeneratedIntColumn _threadId;
  @override
  GeneratedIntColumn get threadId => _threadId ??= _constructThreadId();
  GeneratedIntColumn _constructThreadId() {
    return GeneratedIntColumn(
      'thread_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedIntColumn _timestamp;
  @override
  GeneratedIntColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedIntColumn _constructTimestamp() {
    return GeneratedIntColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subtitleMeta = const VerificationMeta('subtitle');
  GeneratedTextColumn _subtitle;
  @override
  GeneratedTextColumn get subtitle => _subtitle ??= _constructSubtitle();
  GeneratedTextColumn _constructSubtitle() {
    return GeneratedTextColumn(
      'subtitle',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      true,
    );
  }

  final VerificationMeta _filenameMeta = const VerificationMeta('filename');
  GeneratedTextColumn _filename;
  @override
  GeneratedTextColumn get filename => _filename ??= _constructFilename();
  GeneratedTextColumn _constructFilename() {
    return GeneratedTextColumn(
      'filename',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageIdMeta = const VerificationMeta('imageId');
  GeneratedTextColumn _imageId;
  @override
  GeneratedTextColumn get imageId => _imageId ??= _constructImageId();
  GeneratedTextColumn _constructImageId() {
    return GeneratedTextColumn(
      'image_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _extensionMeta = const VerificationMeta('extension');
  GeneratedTextColumn _extension;
  @override
  GeneratedTextColumn get extension => _extension ??= _constructExtension();
  GeneratedTextColumn _constructExtension() {
    return GeneratedTextColumn(
      'extension',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  GeneratedBoolColumn _isFavorite;
  @override
  GeneratedBoolColumn get isFavorite => _isFavorite ??= _constructIsFavorite();
  GeneratedBoolColumn _constructIsFavorite() {
    return GeneratedBoolColumn(
      'is_favorite',
      $tableName,
      false,
    );
  }

  final VerificationMeta _onlineStateMeta =
      const VerificationMeta('onlineState');
  GeneratedIntColumn _onlineState;
  @override
  GeneratedIntColumn get onlineState =>
      _onlineState ??= _constructOnlineState();
  GeneratedIntColumn _constructOnlineState() {
    return GeneratedIntColumn(
      'online_state',
      $tableName,
      false,
    );
  }

  final VerificationMeta _replyCountMeta = const VerificationMeta('replyCount');
  GeneratedIntColumn _replyCount;
  @override
  GeneratedIntColumn get replyCount => _replyCount ??= _constructReplyCount();
  GeneratedIntColumn _constructReplyCount() {
    return GeneratedIntColumn(
      'reply_count',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageCountMeta = const VerificationMeta('imageCount');
  GeneratedIntColumn _imageCount;
  @override
  GeneratedIntColumn get imageCount => _imageCount ??= _constructImageCount();
  GeneratedIntColumn _constructImageCount() {
    return GeneratedIntColumn(
      'image_count',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        boardId,
        threadId,
        timestamp,
        subtitle,
        content,
        filename,
        imageId,
        extension,
        isFavorite,
        onlineState,
        replyCount,
        imageCount
      ];
  @override
  $ThreadsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'threads_table';
  @override
  final String actualTableName = 'threads_table';
  @override
  VerificationContext validateIntegrity(Insertable<ThreadsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id'], _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(_threadIdMeta,
          threadId.isAcceptableOrUnknown(data['thread_id'], _threadIdMeta));
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle'], _subtitleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename'], _filenameMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id'], _imageIdMeta));
    }
    if (data.containsKey('extension')) {
      context.handle(_extensionMeta,
          extension.isAcceptableOrUnknown(data['extension'], _extensionMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite'], _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    context.handle(_onlineStateMeta, const VerificationResult.success());
    if (data.containsKey('reply_count')) {
      context.handle(
          _replyCountMeta,
          replyCount.isAcceptableOrUnknown(
              data['reply_count'], _replyCountMeta));
    } else if (isInserting) {
      context.missing(_replyCountMeta);
    }
    if (data.containsKey('image_count')) {
      context.handle(
          _imageCountMeta,
          imageCount.isAcceptableOrUnknown(
              data['image_count'], _imageCountMeta));
    } else if (isInserting) {
      context.missing(_imageCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {threadId, boardId};
  @override
  ThreadsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ThreadsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ThreadsTableTable createAlias(String alias) {
    return $ThreadsTableTable(_db, alias);
  }

  static TypeConverter<OnlineState, int> $converter0 =
      const EnumIndexConverter<OnlineState>(OnlineState.values);
}

class BoardsTableData extends DataClass implements Insertable<BoardsTableData> {
  final String boardId;
  final String title;
  final bool workSafe;
  BoardsTableData(
      {@required this.boardId, @required this.title, @required this.workSafe});
  factory BoardsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return BoardsTableData(
      boardId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}board_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      workSafe:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}work_safe']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || boardId != null) {
      map['board_id'] = Variable<String>(boardId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || workSafe != null) {
      map['work_safe'] = Variable<bool>(workSafe);
    }
    return map;
  }

  BoardsTableCompanion toCompanion(bool nullToAbsent) {
    return BoardsTableCompanion(
      boardId: boardId == null && nullToAbsent
          ? const Value.absent()
          : Value(boardId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      workSafe: workSafe == null && nullToAbsent
          ? const Value.absent()
          : Value(workSafe),
    );
  }

  factory BoardsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BoardsTableData(
      boardId: serializer.fromJson<String>(json['boardId']),
      title: serializer.fromJson<String>(json['title']),
      workSafe: serializer.fromJson<bool>(json['workSafe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'boardId': serializer.toJson<String>(boardId),
      'title': serializer.toJson<String>(title),
      'workSafe': serializer.toJson<bool>(workSafe),
    };
  }

  BoardsTableData copyWith({String boardId, String title, bool workSafe}) =>
      BoardsTableData(
        boardId: boardId ?? this.boardId,
        title: title ?? this.title,
        workSafe: workSafe ?? this.workSafe,
      );
  @override
  String toString() {
    return (StringBuffer('BoardsTableData(')
          ..write('boardId: $boardId, ')
          ..write('title: $title, ')
          ..write('workSafe: $workSafe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(boardId.hashCode, $mrjc(title.hashCode, workSafe.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BoardsTableData &&
          other.boardId == this.boardId &&
          other.title == this.title &&
          other.workSafe == this.workSafe);
}

class BoardsTableCompanion extends UpdateCompanion<BoardsTableData> {
  final Value<String> boardId;
  final Value<String> title;
  final Value<bool> workSafe;
  const BoardsTableCompanion({
    this.boardId = const Value.absent(),
    this.title = const Value.absent(),
    this.workSafe = const Value.absent(),
  });
  BoardsTableCompanion.insert({
    @required String boardId,
    @required String title,
    @required bool workSafe,
  })  : boardId = Value(boardId),
        title = Value(title),
        workSafe = Value(workSafe);
  static Insertable<BoardsTableData> custom({
    Expression<String> boardId,
    Expression<String> title,
    Expression<bool> workSafe,
  }) {
    return RawValuesInsertable({
      if (boardId != null) 'board_id': boardId,
      if (title != null) 'title': title,
      if (workSafe != null) 'work_safe': workSafe,
    });
  }

  BoardsTableCompanion copyWith(
      {Value<String> boardId, Value<String> title, Value<bool> workSafe}) {
    return BoardsTableCompanion(
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      workSafe: workSafe ?? this.workSafe,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (workSafe.present) {
      map['work_safe'] = Variable<bool>(workSafe.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardsTableCompanion(')
          ..write('boardId: $boardId, ')
          ..write('title: $title, ')
          ..write('workSafe: $workSafe')
          ..write(')'))
        .toString();
  }
}

class $BoardsTableTable extends BoardsTable
    with TableInfo<$BoardsTableTable, BoardsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $BoardsTableTable(this._db, [this._alias]);
  final VerificationMeta _boardIdMeta = const VerificationMeta('boardId');
  GeneratedTextColumn _boardId;
  @override
  GeneratedTextColumn get boardId => _boardId ??= _constructBoardId();
  GeneratedTextColumn _constructBoardId() {
    return GeneratedTextColumn(
      'board_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _workSafeMeta = const VerificationMeta('workSafe');
  GeneratedBoolColumn _workSafe;
  @override
  GeneratedBoolColumn get workSafe => _workSafe ??= _constructWorkSafe();
  GeneratedBoolColumn _constructWorkSafe() {
    return GeneratedBoolColumn(
      'work_safe',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [boardId, title, workSafe];
  @override
  $BoardsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'boards_table';
  @override
  final String actualTableName = 'boards_table';
  @override
  VerificationContext validateIntegrity(Insertable<BoardsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id'], _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('work_safe')) {
      context.handle(_workSafeMeta,
          workSafe.isAcceptableOrUnknown(data['work_safe'], _workSafeMeta));
    } else if (isInserting) {
      context.missing(_workSafeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {boardId};
  @override
  BoardsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BoardsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BoardsTableTable createAlias(String alias) {
    return $BoardsTableTable(_db, alias);
  }
}

abstract class _$MoorDB extends GeneratedDatabase {
  _$MoorDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PostsTableTable _postsTable;
  $PostsTableTable get postsTable => _postsTable ??= $PostsTableTable(this);
  $ThreadsTableTable _threadsTable;
  $ThreadsTableTable get threadsTable =>
      _threadsTable ??= $ThreadsTableTable(this);
  $BoardsTableTable _boardsTable;
  $BoardsTableTable get boardsTable => _boardsTable ??= $BoardsTableTable(this);
  PostsDao _postsDao;
  PostsDao get postsDao => _postsDao ??= PostsDao(this as MoorDB);
  ThreadsDao _threadsDao;
  ThreadsDao get threadsDao => _threadsDao ??= ThreadsDao(this as MoorDB);
  BoardsDao _boardsDao;
  BoardsDao get boardsDao => _boardsDao ??= BoardsDao(this as MoorDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [postsTable, threadsTable, boardsTable];
}