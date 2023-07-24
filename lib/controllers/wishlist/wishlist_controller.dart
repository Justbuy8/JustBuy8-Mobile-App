import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class WishlistController {
  static Future<List<ProductModel>> getProducts({
    required int page,
    required int paginateBy,
  }) async {
    List<ProductModel> products = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      WishListUrl.getUserWishList,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        print(jsonEncode(result['Data']));
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

  static Future<String> deleteOrAddWishlist({
    required String productId,
    bool addToWishlist = false,
    bool deleteFromWishlist = false,
  }) async {
    try {
      var response;
      if (addToWishlist) {
        response = await ApiManager.postRequest(
          {
            "Product_id": productId,
          },
          WishListUrl.addToWishlist,
        );
      }
      if (deleteFromWishlist) {
        response = await ApiManager.postRequest(
          {
            "Product_id": productId,
          },
          WishListUrl.deleteFromWishlist,
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
    return "Something went wrong";
  }
}
