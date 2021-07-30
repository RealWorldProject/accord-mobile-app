import 'dart:io';

import 'package:accord/constant/constant.dart';
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
      return res.data.toString().replaceAll("\n", "");
    } on DioError catch (e) {
      return e.response.data.toString().replaceAll("\n", "");
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
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> fetchUserDetails() async {
    final userToken = await Storage().fetchToken();
    final Map<String, dynamic> user = JwtDecoder.decode(userToken);
    try {
      final res = await dio.get('$baseURL/user/profile/${user['id']}',
          options: Options(
              responseType: ResponseType.plain,
              headers: {HttpHeaders.authorizationHeader: userToken}));
      return res.data;
    } on SocketException {
      throw Exception("Error while connecting to the server.");
    } on DioError catch (e) {
      throw Exception(e.response.data.message);
    }
  }
}
