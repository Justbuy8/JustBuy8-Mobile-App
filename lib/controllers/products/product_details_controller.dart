import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductDetailsModel.dart';

class ProductDetailsController {
  static Future<ProductDetailsModel?> getProducts(productId) async {
    ProductDetailsModel? products;

    final response = await ApiManager.postRequest(
      {
        "product_id": productId,
      },
      ProductsUrl.getProductDetails,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        products = ProductDetailsModel.fromJson(result['Data']);
      } else {
        products;
      }
    } else {
      products;
    }
    return products;
  }
}
