import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/featured_products_model.dart';

class FeaturedProductsController {
  static Future<List<FeaturedProductsModel>> getFeaturedProducts(page,paginate_by) async {
    List<FeaturedProductsModel> products = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginate_by,
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
