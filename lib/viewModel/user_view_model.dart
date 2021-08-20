import 'dart:convert';
import 'package:accord/models/user.dart';
import 'package:accord/responses/login_response.dart';
import 'package:accord/responses/register_response.dart';
import 'package:accord/services/auth_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  User _user;
  User get user => _user;

  String _userToken;
  String get userToken => _userToken;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  Future<void> registerUser(String user) async {
    // status set to [LOADING].
    _data = ResponseExposer.loading();
    try {
      final registerResponseAPI = await AuthService().registerUser(user);
      // sending json response to register_response to convert into object.
      var responseObj =
          RegisterResponse.fromJson(jsonDecode(registerResponseAPI));

      // status set to [COMPLETE] with success message
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      print("object");
      // status set to [ERROR] with error message
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    // status set to [LOADING]
    _data = ResponseExposer.loading();
    try {
      final loginResponseAPI = await AuthService().loginUser(email, password);
      // sending json response to login_response to convert into object
      var responseObj = LoginResponse.fromJson(jsonDecode(loginResponseAPI));

      // token from the login response.
      _userToken = responseObj.token;

      // status set to [COMPLETE] with success message
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // status set to [ERROR] with error message
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  Future<dynamic> fetchUserDetail([String userId = null]) async {
    // setting status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api connection to fecth user data
      final apiResponse = await AuthService().fetchUserDetails(userId);

      // gets user data from the response and assign it to [_user].
      _user = RegisterResponse.fromJson(jsonDecode(apiResponse)).result;

      // setting status to [COMPLETE]
      _data = ResponseExposer.complete();
    } catch (e) {
      // setting status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  Future<dynamic> updateUserDetails({String updatedUser}) async {
    // setting status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api connection to fecth user data
      final apiResponse = await AuthService().updateUser(updatedUser);

      // conversion: json response to response object
      var responseObj = RegisterResponse.fromJson(jsonDecode(apiResponse));

      // gets user data from the response and assign it to [_user].
      _user = responseObj.result;

      // setting status to [COMPLETE]
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // setting status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  Future<dynamic> updateUserPassword(
      {String currentPassword, String newPassword}) async {
    // setting status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api connection to fecth user data
      final apiResponse =
          await AuthService().updateUserPassword(currentPassword, newPassword);

      // conversion: json response to response object
      var responseObj = RegisterResponse.fromJson(jsonDecode(apiResponse));

      // gets user data from the response and assign it to [_user].
      _user = responseObj.result;

      // setting status to [COMPLETE]
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // setting status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  void clearToken() {
    _userToken = null;
  }
}
