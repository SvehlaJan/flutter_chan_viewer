import 'dart:async';
import 'dart:convert';

import 'package:flutter_chan_viewer/api/api_exception.dart';
import 'package:flutter_chan_viewer/models/archive_list_model.dart';
import 'package:flutter_chan_viewer/models/board_detail_model.dart';
import 'package:flutter_chan_viewer/models/board_list_model.dart';
import 'package:flutter_chan_viewer/models/local/threads_table.dart';
import 'package:flutter_chan_viewer/models/thread_detail_model.dart';
import 'package:http/http.dart' show Client;

class ChanApiProvider {
  Client client = Client();
  static final _baseUrl = "https://a.4cdn.org";
  static final baseImageUrl = "https://i.4cdn.org";

  Future<BoardListModel> fetchBoardList() async {
    String url = "$_baseUrl/boards.json";

    final response = await client.get(url);
//    ChanLogger.d("Board list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return BoardListModel.fromJson(json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }

  Future<BoardDetailModel> fetchThreadList(String boardId) async {
    String url = "$_baseUrl/$boardId/catalog.json";

    final response = await client.get(url);
//    ChanLogger.d("Thread list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return BoardDetailModel.fromJson(boardId, OnlineState.ONLINE, json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }

  Future<ThreadDetailModel> fetchPostList(String boardId, int threadId) async {
    String url = "$_baseUrl/$boardId/thread/$threadId.json";

    final response = await client.get(url);
//    ChanLogger.d("Post list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return ThreadDetailModel.fromJson(boardId, threadId, OnlineState.ONLINE, json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }

  Future<ArchiveListModel> fetchArchiveList(String boardId) async {
    String url = "$_baseUrl/$boardId/archive.json";

    final response = await client.get(url);
//    ChanLogger.d("Archive list fetched. { url: $url, response status: ${response.statusCode} }");
    if (response.statusCode == 200) {
      return ArchiveListModel.fromJson(boardId, json.decode(response.body));
    } else {
      throw HttpException(message: response.body, errorCode: response.statusCode);
    }
  }
}
