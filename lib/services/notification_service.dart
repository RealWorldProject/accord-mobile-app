import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class NotificationService {
  Dio dio = Dio();
  String baseUrl = Constant.baseURL;
  String userToken;

  Future<String> fetchNotifications() async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.get(
        "$baseUrl/notifications",
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
}
