import 'dart:convert';

import 'package:accord/models/book.dart';
import 'package:accord/responses/book_response.dart';
import 'package:accord/responses/fetch_books_response.dart';
import 'package:accord/services/book_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class BookViewModel extends ChangeNotifier {
  List<Book> _books;
  List<Book> get books => _books;

  List<Book> _categoricalBooks;
  List<Book> get categoricalBooks => _categoricalBooks;

  List<Book> _searchedBooks = [];
  List<Book> get searchedBooks => _searchedBooks;

  List<Book> _userOwnedBooks;
  List<Book> get userOwnedBooks => _userOwnedBooks;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  // post book
  Future<void> postBook(String book) async {
    _data = ResponseExposer.loading();

    try {
      final postBookResponseAPI = await BookService().postBook(book);

      // sending json response to BookResponse to convert into object
      var responseObj = BookResponse.fromJson(jsonDecode(postBookResponseAPI));

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // fetch all books
  Future<void> fetchAllBooks() async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await BookService().fetchAllBooks();

      // sending json response to FetchBooksResponse to convert into object
      var responseObj = FetchBooksResponse.fromJson(jsonDecode(apiResponse));
      _books = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _books = [];
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // fetch category books
  Future<void> fetchBooksInCategory(String categoryID) async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await BookService().fetchBooksInCategory(categoryID);

      // sending json response to FetchBooksResponse to convert into object
      // then, getting the response object's result
      var responseObj = FetchBooksResponse.fromJson(jsonDecode(apiResponse));
      _categoricalBooks = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _categoricalBooks = [];
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // fetch searched books
  Future<void> fetchSearchedBooks(String searchTerm) async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await BookService().fetchSearchedBooks(searchTerm);

      // sending json response to FetchBooksResponse to convert into object
      // then, getting the response object's result
      var responseObj = FetchBooksResponse.fromJson(jsonDecode(apiResponse));
      _searchedBooks = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _searchedBooks = [];
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // fetch user's books
  Future<void> fetchUserPostedBooks() async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await BookService().fetchUserPostedBooks();

      // sending json response to FetchBooksResponse to convert into object
      // then, getting the response object's result
      var responseObj = FetchBooksResponse.fromJson(jsonDecode(apiResponse));
      _userOwnedBooks = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
      print(_data.status);

    } catch (e) {
      _userOwnedBooks = [];
      _data = ResponseExposer.error(e.toString());
      print(_data.status);
    }

    notifyListeners();
  }

  // update book
  Future<void> updateBook(String updatedBookInfo, String bookID) async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse =
          await BookService().updateBook(updatedBookInfo, bookID);

      // sending json response to FetchBooksResponse to convert into object
      // then, getting the response object's result
      var responseObj = BookResponse.fromJson(jsonDecode(apiResponse));
      Book updatedBook = responseObj.result;

      // find the index of the deleted book index in [userOwnedBooks] by its id
      int updatedBookIndex =
          _userOwnedBooks.indexWhere((book) => updatedBook.id == book.id);

      // injects the updatedBook object in the given index
      _userOwnedBooks[updatedBookIndex] = updatedBook;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _userOwnedBooks = [];
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // delete book
  Future<void> deleteBook(String bookID) async {
    _data = ResponseExposer.loading();
    try {
      final apiResponse = await BookService().deleteBook(bookID);

      // sending json response to BookResponse to convert into object
      // gets the deleted book object.
      var responseObj = BookResponse.fromJson(jsonDecode(apiResponse));
      Book deletedBook = responseObj.result;

      // find the index of the deleted book index in [userOwnedBooks] by its id
      int deletedBookIndex =
          _userOwnedBooks.indexWhere((book) => deletedBook.id == book.id);

      // removes the book from given index.
      _userOwnedBooks.removeAt(deletedBookIndex);

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _userOwnedBooks = [];
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  // reset functions.
  void resetSearch() {
    _searchedBooks = [];
    notifyListeners();
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
