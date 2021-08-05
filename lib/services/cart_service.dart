import 'dart:io';

import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class CartService {
  final String baseURL = Constant.baseURL;
  final dio = Dio();
  final responsebase = ResponseBase();
  String userToken;

  Future<String> addToCart(String cartItem) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio.post(
        "$baseURL/cart",
        data: cartItem,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return responsebase.apiResponse(e.response);
    } on SocketException {
      throw FetchDataException("Error while connecting to the server.");
    }
  }

  Future<String> fetchCartItems() async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio.get(
        "$baseURL/cart",
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return responsebase.apiResponse(e.response);
    } on SocketException {
      throw FetchDataException("Error while connecting to the server.");
    }
  }

  Future<String> deleteCartItem(String cartItem) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio.delete(
        "$baseURL/cart",
        data: cartItem,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return responsebase.apiResponse(e.response);
    } on SocketException {
      throw FetchDataException("Error while connecting to the server.");
    }
  }
}
