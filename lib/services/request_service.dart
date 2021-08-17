import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class RequestService {
  final baseUrl = Constant.baseURL;
  final Dio dio = new Dio();
  String userToken;

  Future<String> requestBook(String requestInfo) async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.post(
        "$baseUrl/request",
        data: requestInfo,
        options: Options(
          responseType: ResponseType.plain,
          headers: {HttpHeaders.authorizationHeader: userToken},
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchIncomingRequests() async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.get(
        "$baseUrl/request/incoming",
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchOutgoingRequests() async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.get(
        "$baseUrl/request/my",
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }
}
