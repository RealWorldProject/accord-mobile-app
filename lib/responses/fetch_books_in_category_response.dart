import 'package:accord/models/book.dart';

class FetchBooksInCategoryResponse {
  final bool success;
  final String message;
  final String developerMessage;
  final List<Book> result;
  final int page;
  final int total;

  FetchBooksInCategoryResponse({
    this.success,
    this.message,
    this.developerMessage,
    this.result,
    this.page,
    this.total,
  });

  factory FetchBooksInCategoryResponse.fromJson(Map<String, dynamic> json) {
    // converting List<String> to List<Book>
    var books = json['result'] as List;
    List<Book> formattedBooks =
        books.map((book) => Book.fromJson(book)).toList();

    return FetchBooksInCategoryResponse(
      success: json['success'],
      message: json['message'],
      developerMessage: json['developerMessage'],
      result: formattedBooks,
      page: json['page'],
      total: json['total'],
    );
  }
}
