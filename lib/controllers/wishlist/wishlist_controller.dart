import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';

class WishlistController {
  static Future<List<ProductModel>> getProducts({
    required int page,
    required int paginateBy,
  }) async {
    List<ProductModel> products = [];
    String? userToken = await UserSecureStorage.fetchToken();

    final response = await ApiManager.postRequest(
      {
        "page": "$page",
        "paginate_by": "$paginateBy",
      },
      WishListUrl.getUserWishList,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
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

  static Future<String> deleteOrAddWishlist({
    required String productId,
    bool addToWishlist = false,
    bool deleteFromWishlist = false,
  }) async {
    String? userToken = await UserSecureStorage.fetchToken();

    try {
      var response;
      if (addToWishlist) {
        response = await ApiManager.postRequest(
          {
            "Product_id": productId,
          },
          WishListUrl.addToWishlist,
          headers: {
            "content-type": "application/json; charset=utf-8",
            'Authorization': 'Bearer ${userToken}'
          },
        );
      }
      if (deleteFromWishlist) {
        response = await ApiManager.postRequest(
          {
            "Product_id": productId,
          },
          WishListUrl.deleteFromWishlist,
          headers: {
            "content-type": "application/json; charset=utf-8",
            'Authorization': 'Bearer ${userToken}'
          },
        );
      }

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body) as Map<String, dynamic>;
        if (result['Success']) {
          return result['Message'];
        } else {
          return result['Message'];
        }
      }
    } catch (error) {
      rethrow;
    }
    return AppText.somethingWentWrong;
  }
}
