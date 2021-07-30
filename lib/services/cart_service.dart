import 'dart:io';

import 'package:accord/constant/constant.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class CartService {
  final String baseURL = Constant.baseURL;
  final dio = Dio();
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
    } on SocketException {
      throw Exception("Error while connecting to the server.");
    } on DioError catch (e) {
      throw Exception(e.response.data.message);
    }
  }

  Future<String> fetchCartItemss() async {
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
    } on SocketException {
      throw Exception("Error while connecting to the server.");
    } on DioError catch (e) {
      throw Exception(e.response.data.message);
    }
  }
}
