import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class ChildCategoryProductsController {
  static Future<List<ProductModel>> getProducts({
    page,
    paginateBy,
    categoryId,
    subCategoryId,
    childCategoryId,
  }) async {
    List<ProductModel> products = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "child_category_id": childCategoryId,
      },
      ProductsUrl.getProductsByMainCategory,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        products = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        products = [];
      }
    } else {
      products = [];
    }
    return products;
  }
}
