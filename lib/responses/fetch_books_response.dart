import 'package:accord/models/book.dart';

class FetchBooksResponse {
  final bool success;
  final String message;
  final String developerMessage;
  final List<Book> result;
  final int page;
  final int total;

  FetchBooksResponse({
    this.success,
    this.message,
    this.developerMessage,
    this.result,
    this.page,
    this.total,
  });

  factory FetchBooksResponse.fromJson(Map<String, dynamic> json) {
    // converting List<String> to List<Book>
    var books = json['result'] as List;
    List<Book> formattedBooks =
        books.map((book) => Book.fromJson(book)).toList();

    return FetchBooksResponse(
      success: json['success'],
      message: json['message'],
      developerMessage: json['developerMessage'],
      result: formattedBooks,
      page: json['page'],
      total: json['total'],
    );
  }
}
