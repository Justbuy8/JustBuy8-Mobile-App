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
      var result = jsonDecode(response.body);
      if (result['Success']) {
        products = featuredProductsModelFromJson(jsonEncode(result['Data']));
      } else {
        products = [];
      }
    } else {
      products = [];
    }
    return products;
  }
}
