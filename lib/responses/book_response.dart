import 'package:accord/models/book.dart';

class BookResponse {
  final bool success;
  final String message;
  final String developerMessage;
  final Book result;

  BookResponse({
    this.success,
    this.message,
    this.developerMessage,
    this.result,
  });

  factory BookResponse.fromJson(Map<String, dynamic> parsedJson) {
    return BookResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      developerMessage: parsedJson['developerMessage'],
      // result: Book.fromJson(parsedJson['result']),
    );
  }
}
