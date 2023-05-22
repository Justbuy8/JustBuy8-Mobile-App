import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class BestProductsController {
  static Future<List<ProductModel>> getBestProducts(
      page, paginateBy, categoryId) async {
    List<ProductModel> bestProducts = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "category_id": categoryId,
      },
      ProductsUrl.bestProducts,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        bestProducts =
            featuredProductsModelFromJson(jsonEncode(result['Data']));
      } else {
        bestProducts = [];
      }
    } else {
      bestProducts = [];
    }
    return bestProducts;
  }
}
