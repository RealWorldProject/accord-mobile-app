import 'dart:io';

import 'package:accord/constant/constant.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class BookService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;

  Future<String> postBook(String book) async {
    final userToken = await Storage().fetchToken();
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
}
