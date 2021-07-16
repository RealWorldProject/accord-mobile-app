import 'package:accord/models/book.dart';

class BookPostResponse {
  final bool success;
  final String message;
  final String developerMessage;
  final Book result;

  BookPostResponse({
    this.success,
    this.message,
    this.developerMessage,
    this.result,
  });

  factory BookPostResponse.fromJson(Map<String, dynamic> json) {
    return BookPostResponse(
      success: json['success'],
      message: json['message'],
      developerMessage: json['developerMessage'],
      result: Book.fromJson(json['result']),
    );
  }
}
