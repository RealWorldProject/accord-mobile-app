import 'dart:convert';
import 'dart:developer';
import 'package:accord/models/user.dart';
import 'package:accord/responses/login_response.dart';
import 'package:accord/responses/register_response.dart';
import 'package:accord/services/auth_service.dart';
import 'package:accord/services/handlers/exposer.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  User _user;
  User get user => _user;

  ResponseExposer _data;
  ResponseExposer get data => _data;

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

  Future<dynamic> fetchUserDetail([String userId = null]) async {
    _data = ResponseExposer.loading();
    try {
      final apiResponse = await AuthService().fetchUserDetails(userId);
      _user = RegisterResponse.fromJson(jsonDecode(apiResponse)).result;
      _data = ResponseExposer.complete();
    } catch (e) {
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }
}
