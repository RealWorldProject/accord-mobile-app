import 'dart:io';

import 'package:accord/constant/constant.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BookService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;

  Future<String> postBook(String book) async {
    final String userToken = await Storage().fetchToken();
    try {
      final res = await dio.post(
        '$baseURL/book',
        data: book,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> fetchBooksInCategory(String categoryID) async {
    final String userToken = await Storage().fetchToken();
    try {
      final res = await dio.get(
        '$baseURL/books',
        queryParameters: {
          "page": 1,
          "limit": 0,
          "categoryID": categoryID,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> fetchAllBooks() async {
    final String userToken = await Storage().fetchToken();
    try {
      final res = await dio.get(
        '$baseURL/books',
        queryParameters: {
          "page": 1,
          "limit": 0,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> fetchSearchedBooks(String searchTerm) async {
    final String userToken = await Storage().fetchToken();
    try {
      final res = await dio.get(
        '$baseURL/books',
        queryParameters: {
          "page": 1,
          "limit": 0,
          "searchTerm": searchTerm,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> fetchUserPostedBooks() async {
    final String userToken = await Storage().fetchToken();
    final Map<String, dynamic> user = JwtDecoder.decode(userToken);
    try {
      final res = await dio.get(
        '$baseURL/books',
        queryParameters: {
          "page": 1,
          "limit": 0,
          "userID": user['id'],
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> fetchSelectedBookDetails(String bookID) async {
    final String userToken = await Storage().fetchToken();
    try {
      final res = await dio.get(
        '$baseURL/books',
        queryParameters: {
          "bookID": bookID,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> updateBook(String updatedBook, String bookID) async {
    final String userToken = await Storage().fetchToken();
    try {
      final res = await dio.put(
        '$baseURL/book/$bookID',
        data: updatedBook,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }
}
