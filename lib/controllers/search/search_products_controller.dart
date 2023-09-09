import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class SearchProductsController {
  static Future<List<ProductModel>> getProducts(String query) async {
    List<ProductModel> searchedProducts = [];

    final response = await ApiManager.postRequest(
      {"query": query},
      ProductsUrl.searchProducts,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        searchedProducts = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        searchedProducts = [];
      }
    } else {
      searchedProducts = [];
    }
    return searchedProducts;
  }
}
