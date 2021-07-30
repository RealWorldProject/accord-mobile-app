import 'dart:convert';
import 'package:accord/models/user.dart';
import 'package:accord/responses/login_response.dart';
import 'package:accord/responses/register_response.dart';
import 'package:accord/services/auth_service.dart';

class UserViewModel {
  final User user;

  UserViewModel({this.user});

  Future<RegisterResponse> registerUser(String user) async {
    final registerResponseAPI = await AuthService().registerUser(user);
    // sending json response to register_response to convert into map
    return RegisterResponse.fromJson(jsonDecode(registerResponseAPI));
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    final loginResponseAPI = await AuthService().loginUser(email, password);
    // sending json response to login_response to convert into map
    return LoginResponse.fromJson(jsonDecode(loginResponseAPI));
  }

  Future<RegisterResponse> fetchUserDetails() async {
    final apiResponse = await AuthService().fetchUserDetails();
    return RegisterResponse.fromJson(jsonDecode(apiResponse));
  }
}
