import 'dart:convert';
import 'package:accord/models/category.dart';
import 'package:accord/responses/fetch_category_response.dart';
import 'package:accord/services/category_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart' as foundation;

class CategoryViewModel extends foundation.ChangeNotifier {
  List<Category> _categories;
  List<Category> get categories => _categories;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  Future<dynamic> fetchCategories() async {
    _data = ResponseExposer.loading();

    try {
      final responseApi = await CategoryService().fetchCategories();
      //sending json response to FetchCategoryResponse to convert into object
      var responseObj = FetchCategoryResponse.fromJson(jsonDecode(responseApi));
      _categories = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _categories = [];
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
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
