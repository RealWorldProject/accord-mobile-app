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

  factory BookPostResponse.fromJson(Map<String, dynamic> parsedJson) {
    return BookPostResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      developerMessage: parsedJson['developerMessage'],
      result: Book.fromJson(parsedJson['result']),
    );
  }
}
