import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class OrderService {
  String baseUrl = Constant.baseURL;
  Dio dio = Dio();
  String userToken;

  Future<String> checkoutOrder(String orderInfo) async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.post(
        "$baseUrl/order",
        data: orderInfo,
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
