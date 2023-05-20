// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class FeaturedProductsController {
  static Future<List<ProductModel>> getFeaturedProducts(
      page, paginate_by) async {
    List<ProductModel> products = [];

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
