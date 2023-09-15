import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class SearchProductsController {
  static Future<List<ProductModel>> getProducts(
    String query, {
    String? method,
    String? category,
    num? startingPrice,
    num? endingPrice,
    String? totalRatings,
  }) async {
    List<ProductModel> searchedProducts = [];

    print("$category $method $startingPrice $endingPrice $totalRatings");

    final response = await ApiManager.postRequest(
      {
        "query": query,
        "method": method,
        "category": category,
        "starting_price": startingPrice,
        "ending_price": endingPrice,
        "total_ratings": totalRatings,
      },
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
