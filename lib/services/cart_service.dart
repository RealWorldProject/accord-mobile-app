import 'dart:io';

import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
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
      return apiResponse(res);
    } on SocketException {
      throw FetchDataException("Error while connecting to the server.");
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
      return apiResponse(res);
    } on SocketException {
      throw FetchDataException("Error while connecting to the server.");
    }
  }

  dynamic apiResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data.message);
      case 403:
        throw UnauthorizedException(response.data.message);
      case 500:
        throw ServerException(
            "Something went wrong on our side. We would appreciate it " +
                "if you could manage some of your time to report this problem. Thank you.");
      default:
        throw FetchDataException(
            "Error occured while trying to connect to the server: ${response.statusCode}");
    }
  }
}
