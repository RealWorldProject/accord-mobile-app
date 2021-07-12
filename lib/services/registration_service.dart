import 'package:accord/services/baseURL.dart';
import 'package:dio/dio.dart';

class RegistrationService {
  Dio dio = new Dio();

  Future registerUser(fullName, email, password) async {
    // print('$fullName \n$email \n$password');
    try {
      var response = await dio.post('${baseURL()}/v1/user/register',
          data: {'fullName': fullName, 'email': email, 'password': password});
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }
}
