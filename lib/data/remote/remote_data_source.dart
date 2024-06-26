import 'dart:async';
import 'dart:convert';

import 'package:flutter_chan_viewer/models/archive_list_model.dart';
import 'package:flutter_chan_viewer/models/board_detail_model.dart';
import 'package:flutter_chan_viewer/models/board_list_model.dart';
import 'package:flutter_chan_viewer/models/helper/online_state.dart';
import 'package:flutter_chan_viewer/models/thread_detail_model.dart';
import 'package:flutter_chan_viewer/utils/exceptions.dart';
import 'package:flutter_chan_viewer/utils/flavor_config.dart';
import 'package:http/http.dart' show Client;
import 'package:logger/logger.dart';

class RemoteDataSource {
  final logger = Logger();
  Client client = Client();

  Future<BoardListModel> fetchBoardList() async {
    String url = "${FlavorConfig.values().baseUrl}/boards.json";

    final response = await client.get(Uri.parse(url));
//    logDebug("Board list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return BoardListModel.fromJson(json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }

  Future<BoardDetailModel> fetchThreadList(String boardId) async {
    String url = "${FlavorConfig.values().baseUrl}/$boardId/catalog.json";

    final response = await client.get(Uri.parse(url));
//    logDebug("Thread list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return BoardDetailModel.fromJson(boardId, OnlineState.ONLINE, json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }

  Future<ThreadDetailModel> fetchThreadDetail(String boardId, int threadId, bool isArchived) async {
    String url = "${FlavorConfig.values().baseUrl}/$boardId/thread/$threadId.json";

    final response = await client.get(Uri.parse(url));
//    logDebug("Post list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return ThreadDetailModel.fromJson(
          boardId, threadId, isArchived ? OnlineState.ARCHIVED : OnlineState.ONLINE, json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }

  Future<ArchiveListModel> fetchArchiveList(String boardId) async {
    String url = "${FlavorConfig.values().baseUrl}/$boardId/archive.json";

    final response = await client.get(Uri.parse(url));
//    logDebug("Archive list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return ArchiveListModel.fromJson(boardId, json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }
}
