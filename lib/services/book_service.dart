import 'dart:async';
import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BookService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;
  String userToken;

  Future<String> postBook(String book) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .post(
            '$baseURL/book',
            data: book,
            options: Options(
              responseType: ResponseType.plain,
              headers: {
                HttpHeaders.authorizationHeader: userToken,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchBooksInCategory(String categoryID) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .get(
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
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchAllBooks() async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .get(
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
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchSearchedBooks(String searchTerm) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .get(
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
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchUserPostedBooks() async {
    userToken = await Storage().fetchToken();
    final Map<String, dynamic> user = JwtDecoder.decode(userToken);
    try {
      final res = await dio
          .get(
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
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> updateBook(String updatedBookInfo, String bookID) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .put(
            '$baseURL/book/$bookID',
            data: updatedBookInfo,
            options: Options(
              responseType: ResponseType.plain,
              headers: {
                HttpHeaders.authorizationHeader: userToken,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> deleteBook(String bookID) async {
    userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .delete(
            '$baseURL/book/$bookID',
            options: Options(
              responseType: ResponseType.plain,
              headers: {
                HttpHeaders.authorizationHeader: userToken,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
      return res.data;
    } on TimeoutException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }
}
