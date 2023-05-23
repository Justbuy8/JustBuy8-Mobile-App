// ignore_for_file: file_names

import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

class CategoryController {
  static Future<List<CategoryModel>> getTopCategories(
    page,
    paginateBy,
  ) async {
    List<CategoryModel> topCategories = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      CategoriesUrl.topCategories,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        result['Data'].forEach((category) {
          topCategories.add(CategoryModel.fromJson(category));
        });
      } else {
        topCategories = [];
      }
    } else {
      topCategories = [];
    }
    return topCategories;
  }

  static Future<List<CategoryModel>> getMainCategories(
    String page,
    String paginateBy,
  ) async {
    List<CategoryModel> mainCategories = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      CategoriesUrl.mainCategories,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['Success']) {
        data['Data'].forEach((category) {
          category["productCount"];
          mainCategories.add(CategoryModel.fromJson(category));
        });

        // var result = jsonDecode(response.body);
        // if (result['Success']) {
        //   result['Data'].forEach((category) {
        //     mainCategories.add(CategoriesModel.fromJson(category));
        //   });
      } else {
        mainCategories = [];
      }
    } else {
      mainCategories = [];
    }
    return mainCategories;
  }
}
