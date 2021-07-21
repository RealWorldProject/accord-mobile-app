import 'dart:io';

import 'package:accord/constant/constant.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;

  Future<String> fetchCategories() async {
    final userToken = await Storage().fetchToken();
    try {
      final res = await dio.get(
        '$baseURL/categories',
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
