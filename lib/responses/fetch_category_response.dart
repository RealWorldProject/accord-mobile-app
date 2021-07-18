import 'package:accord/models/category.dart';

class FetchCategoryResponse {
  final bool success;
  final String message;
  final String developerMessage;
  final List<Category> result;
  final int page;
  final int total;

  FetchCategoryResponse({
    this.success,
    this.message,
    this.developerMessage,
    this.result,
    this.page,
    this.total,
  });

  factory FetchCategoryResponse.fromJson(Map<String, dynamic> parsedJson) {
    // converting List<String> in `result` to List<Category>
    var categories = parsedJson['result'] as List;
    List<Category> categoriesList =
        categories.map((category) => Category.fromJson(category)).toList();

    return FetchCategoryResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      developerMessage: parsedJson['developerMessage'],
      result: categoriesList,
      page: parsedJson['page'],
      total: parsedJson['total'],
    );
  }
}
