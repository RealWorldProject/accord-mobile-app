class LoginResponse {
  final bool success;
  final String message;
  // final String developerMessage;
  // final List result;
  final String token;
  final int permissionLevel;

  LoginResponse(
      {this.success,
      this.message,
      // this.developerMessage,
      // this.result,
      this.token,
      this.permissionLevel});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      // developerMessage: json['developerMessage'],
      // result: json['result'],
      token: json['token'],
      permissionLevel: json['permissionLevel'],
    );
  }
}
