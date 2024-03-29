import 'package:flutter_chan_viewer/models/helper/chan_post_base.dart';
import 'package:flutter_chan_viewer/models/thread_detail_model.dart';
import 'package:flutter_chan_viewer/repositories/chan_downloader.dart';

class ChanDownloaderMock extends ChanDownloader {
  @override
  Future<void> downloadThreadMedia(ThreadDetailModel model) async {}

  @override
  Future<void> initializeAsync() async {}

  @override
  Future<void> cancelThreadDownload(ThreadDetailModel model) async {}

  @override
  Future<void> cancelAllDownloads() async {}

  @override
  bool isMediaDownloaded(ChanPostBase post) {
    return false;
  }
}
