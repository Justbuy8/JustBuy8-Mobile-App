import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class WishlistController {
  static Future<List<ProductModel>> getProducts(
      String userId, String userToken) async {
    List<ProductModel> products = [];

    final response = await ApiManager.postRequest(
      {
        "UserId": userId,
        "Token": userToken,
      },
      WishListUrl.getUserWishList,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        products = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        products = [];
      }
    } else {
      print(response.statusCode);
      products = [];
    }
    return products;
  }
}
