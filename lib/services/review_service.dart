import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/handlers/exception_handlers.dart';
import 'package:accord/services/handlers/response_base.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class ReviewService {
  final Dio dio = Dio();
  final String baseUrl = Constant.baseURL;
  String userToken;

  Future<String> postReview(String bookID, String review) async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.post(
        "$baseUrl/review/$bookID",
        data: review,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> fetchCurrentBookReview(String bookID) async {
    userToken = await Storage().fetchToken();

    try {
      var res = await dio.get(
        "$baseUrl/review/$bookID",
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> editReview(String reviewID, String updatedReview) async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.patch(
        "$baseUrl/review/$reviewID",
        data: updatedReview,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }

  Future<String> deleteReview(String reviewID) async {
    userToken = await Storage().fetchToken();
    try {
      var res = await dio.delete(
        "$baseUrl/review/$reviewID",
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.authorizationHeader: userToken,
          },
        ),
      );
      return res.data;
    } on SocketException {
      throw FetchDataException(AccordLabels.connectionErrorMessage);
    } on DioError catch (e) {
      return ResponseBase().apiResponse(e.response);
    }
  }
}
