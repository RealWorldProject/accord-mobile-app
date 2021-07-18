import 'dart:convert';
import 'package:accord/models/category.dart';
import 'package:accord/responses/fetch_category_response.dart';
import 'package:accord/services/category_service.dart';

class CategoryViewModel {
  Future<FetchCategoryResponse> fetchCategories() async {
    final responseApi = await CategoryService().fetchCategories();
    //sending json response to FetchCategoryResponse to convert into object
    return FetchCategoryResponse.fromJson(jsonDecode(responseApi));
  }
}

class CategoryModelReader {
  final Category categoryObj;

  CategoryModelReader({this.categoryObj});

  String get id {
    return this.categoryObj.id;
  }

  String get category {
    return this.categoryObj.category;
  }

  String get slug {
    return this.categoryObj.slug;
  }

  String get displayName {
    return this.categoryObj.displayName;
  }

  String get image {
    return this.categoryObj.image;
  }
}
