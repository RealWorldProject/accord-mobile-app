import 'package:accord/constant/constant.dart';
import 'package:dio/dio.dart';

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
}
