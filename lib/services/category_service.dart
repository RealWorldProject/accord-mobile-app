import 'dart:async';
import 'dart:io';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/constant/constant.dart';
import 'package:accord/services/storage.dart';
import 'package:dio/dio.dart';

import 'handlers/exception_handlers.dart';

class CategoryService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;

  Future<String> fetchCategories() async {
    final userToken = await Storage().fetchToken();
    try {
      final res = await dio
          .get(
            '$baseURL/categories',
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
    } on DioError catch (e) {
      return e.response.data;
    }
  }
}
