import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_chan_viewer/repositories/cache_directive.dart';
import 'package:flutter_chan_viewer/utils/log_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChanStorage {
  final logger = LogUtils.getLogger();
  static const String PERMANENT_DIR = "saved";
  static const String SEPARATOR = "/";

  late Directory _permanentDirectory;

  Future<void> initializeAsync() async {
    _permanentDirectory = Directory(join((await getApplicationSupportDirectory()).path, PERMANENT_DIR));
    if (!_permanentDirectory.existsSync()) await _permanentDirectory.create();

    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
  }

  Future<bool> mediaFileExists(String url, CacheDirective cacheDirective) async =>
      await File(join(_permanentDirectory.path, _getFileRelativePath(url, cacheDirective))).exists();

  @Deprecated("Use mediaFileExists instead")
  bool mediaFileExistsSync(String url, CacheDirective cacheDirective) =>
      File(join(_permanentDirectory.path, _getFileRelativePath(url, cacheDirective))).existsSync();

  Future<List<String>> listDirectory(CacheDirective cacheDirective) async =>
      (await Directory(getFolderAbsolutePath(cacheDirective)).list(recursive: true).map((file) => file.path)).toList();

  String getFolderAbsolutePath(CacheDirective cacheDirective) =>
      join(_permanentDirectory.path, _getFolderRelativePath(cacheDirective));

  String getFileAbsolutePath(String url, CacheDirective cacheDirective) =>
      join(_permanentDirectory.path, _getFileRelativePath(url, cacheDirective));

  String _getFolderRelativePath(CacheDirective cacheDirective) =>
      "${cacheDirective.boardId}$SEPARATOR${cacheDirective.threadId}";

  String _getFileRelativePath(String url, CacheDirective cacheDirective) =>
      "${cacheDirective.boardId}$SEPARATOR${cacheDirective.threadId}$SEPARATOR${basename(url)}";

  File? getMediaFile(String url, CacheDirective cacheDirective) {
    try {
      return File(getFileAbsolutePath(url, cacheDirective));
    } catch (e, stackTrace) {
      logger.e("File read error!", e, stackTrace);
    }
    return null;
  }

  Future<Uint8List?> readMediaData(String name, CacheDirective cacheDirective) async {
    try {
      File mediaFile = File(getFileAbsolutePath(name, cacheDirective));
      Uint8List data = await mediaFile.readAsBytes();
      return data;
    } catch (e) {
//      logger.e("File read error!", e, stackTrace);
      return null;
    }
  }

  Future<File?> writeMediaFile(String name, CacheDirective cacheDirective, Uint8List data) async {
    try {
      Directory directory = Directory(getFolderAbsolutePath(cacheDirective));
      if (!directory.existsSync()) await directory.create(recursive: true);

      File mediaFile = File(join(directory.path, basename(name)));
      File result = await mediaFile.writeAsBytes(data, flush: false);
      return result;
    } catch (e, stackTrace) {
      logger.e("File write error!", e, stackTrace);
      return null;
    }
  }

  Future<void> deleteMediaFile(String name, CacheDirective cacheDirective) async {
    try {
      Directory directory = Directory(getFolderAbsolutePath(cacheDirective));
      if (!directory.existsSync()) return null;
      File file = File(join(directory.path, name));
      if (!file.existsSync()) return null;
      file.deleteSync(recursive: true);
      return null;
    } catch (e, stackTrace) {
      logger.e("File delete error!", e, stackTrace);
      return null;
    }
  }

  Future<File?> copyMediaFile(
      String name, CacheDirective sourceCacheDirective, CacheDirective targetCacheDirective) async {
    try {
      File sourceMediaFile = File(getFileAbsolutePath(name, sourceCacheDirective));
      Uint8List data = await sourceMediaFile.readAsBytes();

      Directory targetDirectory = Directory(getFolderAbsolutePath(targetCacheDirective));
      if (!targetDirectory.existsSync()) await targetDirectory.create(recursive: true);

      File targetMediaFile = File(join(targetDirectory.path, basename(name)));
      File result = await targetMediaFile.writeAsBytes(data, flush: false);
      return result;
    } catch (e, stackTrace) {
      logger.e("File copy error!", e, stackTrace);
      return null;
    }
  }

  Future<void> deleteMediaDirectory(CacheDirective cacheDirective) async {
    try {
      Directory directory = Directory(getFolderAbsolutePath(cacheDirective));
      if (!directory.existsSync()) return null;

      directory.deleteSync(recursive: true);
      return null;
    } catch (e, stackTrace) {
      logger.e("File delete error!", e, stackTrace);
      return null;
    }
  }

  Future<HashMap<String, List<String>>?> listDirectories() async {
    try {
      Directory boardsDirectory = Directory(_permanentDirectory.path);
      if (!boardsDirectory.existsSync()) await boardsDirectory.create(recursive: true);

      HashMap<String, List<String>> threadMap = HashMap();
      List<String> boards = boardsDirectory.listSync().map((file) => basename(file.path)).toList();
      for (String board in boards) {
        Directory threadDirectory = Directory(join(_permanentDirectory.path, board));
        List<String> threads = threadDirectory.listSync().map((file) => basename(file.path)).toList();
        threadMap[board] = threads;
      }

      return threadMap;
    } catch (e, stackTrace) {
      logger.e("Error listing downloads!", e, stackTrace);
      return null;
    }
  }

  DownloadFolderInfo getThreadDownloadFolderInfo(CacheDirective cacheDirective) {
    Directory threadDirectory = Directory(getFolderAbsolutePath(cacheDirective));
    DownloadFolderInfo folderInfo = _getThreadFolderInfo(threadDirectory, cacheDirective.boardId);
    return folderInfo;
  }

  List<DownloadFolderInfo>? getAllDownloadFoldersInfo() {
    try {
      List<DownloadFolderInfo> downloadedFolders = <DownloadFolderInfo>[];
      Directory boardsDirectory = Directory(_permanentDirectory.path);
      if (!boardsDirectory.existsSync()) boardsDirectory.createSync(recursive: true);

      for (FileSystemEntity boardFile in boardsDirectory.listSync()) {
        if (boardFile is Directory) {
          downloadedFolders.addAll(_getBoardFolderInfo(boardFile));
        }
      }

      return downloadedFolders;
    } catch (e, stackTrace) {
      logger.e("File read error!", e, stackTrace);
      return null;
    }
  }

  List<DownloadFolderInfo> _getBoardFolderInfo(Directory boardDirectory) {
    String boardName = basename(boardDirectory.path);
    List<DownloadFolderInfo> boardFolders = [];
    for (FileSystemEntity threadFile in boardDirectory.listSync()) {
      if (threadFile is Directory) {
        boardFolders.add(_getThreadFolderInfo(threadFile, boardName));
      }
    }
    return boardFolders;
  }

  DownloadFolderInfo _getThreadFolderInfo(Directory threadDirectory, String boardId) {
    int filesSize = 0;
    int filesCount = 0;
    List<String> fileNames = [];
    threadDirectory.listSync().forEach((file) {
      fileNames.add(basename(file.path));
      filesSize += (file is File) ? file.lengthSync() : 0;
      filesCount += 1;
    });
    String threadName = basename(threadDirectory.path);
    CacheDirective cacheDirective = CacheDirective(boardId, int.parse(threadName));
    return DownloadFolderInfo(cacheDirective, filesCount, filesSize, fileNames);
  }

  Future<void> createDirectory(CacheDirective cacheDirective) async {
    Directory directory = Directory(getFolderAbsolutePath(cacheDirective));
    if (!directory.existsSync()) await directory.create(recursive: true);
  }
}

class DownloadFolderInfo {
  DownloadFolderInfo(this.cacheDirective, this.filesCount, this.filesSize, this.fileNames);

  final CacheDirective cacheDirective;
  final int filesCount;
  final int filesSize;
  final List<String> fileNames;
}
