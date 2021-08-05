import 'dart:convert';
import 'package:dio/dio.dart';
import 'exception_handlers.dart';

class ResponseBase {
  dynamic apiResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 400:
        final responseData = json.decode(response.data);
        throw BadRequestException(responseData["message"]);
      case 403:
        final responseData = json.decode(response.data);
        throw UnauthorizedException(responseData["message"]);
      case 404:
        throw InvalidAddressException("404 Server not found");
      case 500:
        final responseData = json.decode(response.data);
        throw ServerException(responseData["message"]);
      default:
        throw FetchDataException(
            "Error occured while trying to connect to the server: ${response.statusCode}");
    }
  }
}
