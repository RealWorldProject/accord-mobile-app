import 'package:accord/services/baseURL.dart';
import 'package:dio/dio.dart';

class LoginService {
  var dio = new Dio();

  Future loginUser(email, password) async {
    try {
      var response = await dio.post('${baseURL()}/v1/user/login',
          data: {'email': email, 'password': password});
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }
}
