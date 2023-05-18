import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

class CategoriesController {
  static Future<List<CategoriesModel>> getTopCategories(
    page,
    paginateBy,
  ) async {
    List<CategoriesModel> topCategories = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      CategoriesUrl.topCategories,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        result['Data'].forEach((category) {
          topCategories.add(CategoriesModel.fromJson(category));
        });
      } else {
        topCategories = [];
      }
    } else {
      topCategories = [];
    }
    return topCategories;
  }
}
