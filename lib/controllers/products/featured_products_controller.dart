import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/featured_products_model.dart';

class FeaturedProductsController {
  static Future<List<FeaturedProductsModel>> getFeaturedProducts() async {
    List<FeaturedProductsModel> products = [];

    final response = await ApiManager.postRequest(
      {
        "page": "1",
        "paginate_by": "5",
      },
      ProductsUrl.featuredProducts,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );
    if (response.statusCode == 200) {
      print("status code: ${response.statusCode}");
      var result = jsonDecode(response.body);
      print("result: $result");
      if (result['Success']) {
        products = featuredProductsModelFromJson(jsonEncode(result['Data']));
      } else {
        products = [];
      }
    } else {
      print("status code: ${response.statusCode}");
      products = [];
    }
    return products;
  }
}
