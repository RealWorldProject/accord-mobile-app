import 'dart:convert';

import 'package:accord/models/book.dart';
import 'package:accord/responses/book_post_response.dart';
import 'package:accord/responses/fetch_books_response.dart';
import 'package:accord/services/book_service.dart';

class BookViewModel {
  Future<BookPostResponse> postBook(String book) async {
    final postBookResponseAPI = await BookService().postBook(book);
    // sending json response to BookPostResponse to convert into object
    return BookPostResponse.fromJson(jsonDecode(postBookResponseAPI));
  }

  Future<FetchBooksResponse> fetchBooksInCategory(String categoryID) async {
    final apiResponse = await BookService().fetchBooksInCategory(categoryID);
    // sending json response to FetchBooksInCategoryResponse to convert into object
    return FetchBooksResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<FetchBooksResponse> fetchAllBooks() async {
    final apiResponse = await BookService().fetchAllBooks();
    // sending json response to FetchBooksResponse to convert into object
    return FetchBooksResponse.fromJson(jsonDecode(apiResponse));
  }
}

class BookModelReader {
  final Book book;

  BookModelReader({this.book});

  String get id {
    return this.book.id;
  }

  String get name {
    return this.book.name;
  }

  List<String> get images {
    return this.book.images;
  }

  String get description {
    return this.book.description;
  }

  String get author {
    return this.book.author;
  }

  String get category {
    return this.book.category;
  }

  bool get isNew {
    return this.book.isNew;
  }

  bool get isAvailableForExchange {
    return this.book.isAvailableForExchange;
  }
}
