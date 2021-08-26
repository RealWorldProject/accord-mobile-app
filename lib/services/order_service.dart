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

  /// post user's order to the server.
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

  /// gets all registered orders of the logged in user from the server
  Future<String> fetchUserOrders() async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.get(
        "$baseUrl/orders",
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

  /// post user's order to the server.
  Future<String> cancelOrder(String orderID) async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.patch(
        "$baseUrl/order/$orderID",
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
