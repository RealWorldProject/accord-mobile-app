import 'dart:convert';

import 'package:accord/models/book.dart';
import 'package:accord/responses/book_response.dart';
import 'package:accord/responses/fetch_books_response.dart';
import 'package:accord/services/book_service.dart';

class BookViewModel {
  Future<BookResponse> postBook(String book) async {
    final postBookResponseAPI = await BookService().postBook(book);
    // sending json response to BookResponse to convert into object
    return BookResponse.fromJson(jsonDecode(postBookResponseAPI));
  }

  Future<FetchBooksResponse> fetchBooksInCategory(String categoryID) async {
    final apiResponse = await BookService().fetchBooksInCategory(categoryID);
    // sending json response to FetchBooksResponse to convert into object
    return FetchBooksResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<FetchBooksResponse> fetchAllBooks() async {
    final apiResponse = await BookService().fetchAllBooks();
    // sending json response to FetchBooksResponse to convert into object
    return FetchBooksResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<FetchBooksResponse> fetchSearchedBooks(String searchTerm) async {
    final apiResponse = await BookService().fetchSearchedBooks(searchTerm);
    // sending json response to FetchBooksResponse to convert into object
    return FetchBooksResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<FetchBooksResponse> fetchUserPostedBooks() async {
    final apiResponse = await BookService().fetchUserPostedBooks();
    // sending json response to FetchBooksResponse to convert into object
    return FetchBooksResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<BookResponse> fetchSelectedBookDetails(String bookID) async {
    final apiResponse = await BookService().fetchSelectedBookDetails(bookID);
    // sending json response to BookResponse to convert into object
    return BookResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<BookResponse> updateBook(String updatedBook, String bookID) async {
    final apiResponse = await BookService().updateBook(updatedBook, bookID);
    // sending json response to BookResponse to convert into object
    return BookResponse.fromJson(jsonDecode(apiResponse));
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

  bool get isNewBook {
    return this.book.isNewBook;
  }

  bool get isAvailableForExchange {
    return this.book.isAvailableForExchange;
  }
}
