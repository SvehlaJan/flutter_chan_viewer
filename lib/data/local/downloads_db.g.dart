// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads_db.dart';

// ignore_for_file: type=lint
class $DownloadsTableTable extends DownloadsTable
    with TableInfo<$DownloadsTableTable, DownloadsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
      'media_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
      'progress', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [mediaId, url, path, filename, status, progress, timestamp];
  @override
  String get aliasedName => _alias ?? 'downloads_table';
  @override
  String get actualTableName => 'downloads_table';
  @override
  VerificationContext validateIntegrity(Insertable<DownloadsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_id')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta));
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mediaId};
  @override
  DownloadsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadsTableData(
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}progress'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $DownloadsTableTable createAlias(String alias) {
    return $DownloadsTableTable(attachedDatabase, alias);
  }
}

class DownloadsTableData extends DataClass
    implements Insertable<DownloadsTableData> {
  final String mediaId;
  final String url;
  final String path;
  final String filename;
  final int status;
  final int progress;
  final int timestamp;
  const DownloadsTableData(
      {required this.mediaId,
      required this.url,
      required this.path,
      required this.filename,
      required this.status,
      required this.progress,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_id'] = Variable<String>(mediaId);
    map['url'] = Variable<String>(url);
    map['path'] = Variable<String>(path);
    map['filename'] = Variable<String>(filename);
    map['status'] = Variable<int>(status);
    map['progress'] = Variable<int>(progress);
    map['timestamp'] = Variable<int>(timestamp);
    return map;
  }

  DownloadsTableCompanion toCompanion(bool nullToAbsent) {
    return DownloadsTableCompanion(
      mediaId: Value(mediaId),
      url: Value(url),
      path: Value(path),
      filename: Value(filename),
      status: Value(status),
      progress: Value(progress),
      timestamp: Value(timestamp),
    );
  }

  factory DownloadsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadsTableData(
      mediaId: serializer.fromJson<String>(json['mediaId']),
      url: serializer.fromJson<String>(json['url']),
      path: serializer.fromJson<String>(json['path']),
      filename: serializer.fromJson<String>(json['filename']),
      status: serializer.fromJson<int>(json['status']),
      progress: serializer.fromJson<int>(json['progress']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaId': serializer.toJson<String>(mediaId),
      'url': serializer.toJson<String>(url),
      'path': serializer.toJson<String>(path),
      'filename': serializer.toJson<String>(filename),
      'status': serializer.toJson<int>(status),
      'progress': serializer.toJson<int>(progress),
      'timestamp': serializer.toJson<int>(timestamp),
    };
  }

  DownloadsTableData copyWith(
          {String? mediaId,
          String? url,
          String? path,
          String? filename,
          int? status,
          int? progress,
          int? timestamp}) =>
      DownloadsTableData(
        mediaId: mediaId ?? this.mediaId,
        url: url ?? this.url,
        path: path ?? this.path,
        filename: filename ?? this.filename,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('DownloadsTableData(')
          ..write('mediaId: $mediaId, ')
          ..write('url: $url, ')
          ..write('path: $path, ')
          ..write('filename: $filename, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(mediaId, url, path, filename, status, progress, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadsTableData &&
          other.mediaId == this.mediaId &&
          other.url == this.url &&
          other.path == this.path &&
          other.filename == this.filename &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.timestamp == this.timestamp);
}

class DownloadsTableCompanion extends UpdateCompanion<DownloadsTableData> {
  final Value<String> mediaId;
  final Value<String> url;
  final Value<String> path;
  final Value<String> filename;
  final Value<int> status;
  final Value<int> progress;
  final Value<int> timestamp;
  final Value<int> rowid;
  const DownloadsTableCompanion({
    this.mediaId = const Value.absent(),
    this.url = const Value.absent(),
    this.path = const Value.absent(),
    this.filename = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadsTableCompanion.insert({
    required String mediaId,
    required String url,
    required String path,
    required String filename,
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : mediaId = Value(mediaId),
        url = Value(url),
        path = Value(path),
        filename = Value(filename);
  static Insertable<DownloadsTableData> custom({
    Expression<String>? mediaId,
    Expression<String>? url,
    Expression<String>? path,
    Expression<String>? filename,
    Expression<int>? status,
    Expression<int>? progress,
    Expression<int>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaId != null) 'media_id': mediaId,
      if (url != null) 'url': url,
      if (path != null) 'path': path,
      if (filename != null) 'filename': filename,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadsTableCompanion copyWith(
      {Value<String>? mediaId,
      Value<String>? url,
      Value<String>? path,
      Value<String>? filename,
      Value<int>? status,
      Value<int>? progress,
      Value<int>? timestamp,
      Value<int>? rowid}) {
    return DownloadsTableCompanion(
      mediaId: mediaId ?? this.mediaId,
      url: url ?? this.url,
      path: path ?? this.path,
      filename: filename ?? this.filename,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadsTableCompanion(')
          ..write('mediaId: $mediaId, ')
          ..write('url: $url, ')
          ..write('path: $path, ')
          ..write('filename: $filename, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DownloadsDB extends GeneratedDatabase {
  _$DownloadsDB(QueryExecutor e) : super(e);
  _$DownloadsDB.connect(DatabaseConnection c) : super.connect(c);
  late final $DownloadsTableTable downloadsTable = $DownloadsTableTable(this);
  late final DownloadsDao downloadsDao = DownloadsDao(this as DownloadsDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [downloadsTable];
}
