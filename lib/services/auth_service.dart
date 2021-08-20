import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;

  Future registerUser(String user) async {
    try {
      final res = await dio.post(
        '$baseURL/user/register',
        data: user,
        options: Options(responseType: ResponseType.plain),
      );
      return res.data;
    } on SocketException {
      throw Exception(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future loginUser(email, password) async {
    try {
      final res = await dio.post(
        '$baseURL/user/login',
        data: {'email': email, 'password': password},
        options: Options(responseType: ResponseType.plain),
      );
      return res.data;
    } on SocketException {
      throw Exception(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchUserDetails([String userId = null]) async {
    final userToken = await Storage().fetchToken();
    userId = userId ?? JwtDecoder.decode(userToken)['id'];
    try {
      final res = await dio.get(
        '$baseURL/user/profile/$userId',
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw Exception(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> updateUser(String updatedUser) async {
    final userToken = await Storage().fetchToken();
    try {
      final res = await dio.patch(
        '$baseURL/user/profile',
        data: updatedUser,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw Exception(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> updateUserPassword(
      String currentPassword, String newPassword) async {
    final userToken = await Storage().fetchToken();
    try {
      final res = await dio.patch(
        '$baseURL/user/password',
        data: {'oldPassword': currentPassword, 'newPassword': newPassword},
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw Exception(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }
}
