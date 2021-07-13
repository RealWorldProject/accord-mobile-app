class RegisterResponse {
  final bool success;
  final String message;
  // final String developerMessage;
  // final List result;

  RegisterResponse({
    this.success,
    this.message,
    // this.developerMessage,
    // this.result,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'],
      message: json['message'],
      // developerMessage: json['developerMessage'],
      // result: json['result'],
    );
  }
}
