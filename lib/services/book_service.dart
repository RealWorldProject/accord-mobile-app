import 'package:accord/constant/constant.dart';
import 'package:dio/dio.dart';

class BookService {
  final dio = new Dio();
  final baseURL = Constant.baseURL;

  Future<Map<String, dynamic>> postBook(String book) async {
    try {
      final res = await dio.post(
        '$baseURL/book',
        data: book,
        options: Options(responseType: ResponseType.plain),
      );
      return res.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }
}
