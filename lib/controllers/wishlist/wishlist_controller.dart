// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';

// Create a class for WishlistController
class WishlistController {
  // Static method to fetch products from the user's wishlist
  static Future<List<ProductModel>> getProducts({
    required int page,
    required int paginateBy,
  }) async {
    // Create a list to store the wishlist products
    List<ProductModel> products = [];

    // Fetch the user's token from secure storage
    String? userToken = await UserSecureStorage.fetchToken();

    // Make a POST request to get the products in the user's wishlist
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

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Convert the data into a list of ProductModel objects
        products = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        // If the request was not successful, set the products list to empty
        products = [];
      }
    } else {
      // If the response status code is not 200, set the products list to empty
      products = [];
    }

    // Return the list of wishlist products
    return products;
  }

  // Static method to add or delete a product from the user's wishlist
  static Future<String> deleteOrAddWishlist({
    required String productId,
    bool addToWishlist = false,
    bool deleteFromWishlist = false,
  }) async {
    // Fetch the user's token from secure storage
    String? userToken = await UserSecureStorage.fetchToken();

    try {
      var response;
      if (addToWishlist) {
        // Make a POST request to add the product to the user's wishlist
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
        // Make a POST request to delete the product from the user's wishlist
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
          // Return the success message from the server
          return result['Message'];
        } else {
          // Return the error message from the server
          return result['Message'];
        }
      }
    } catch (error) {
      // Handle any errors that occur during the request
      rethrow;
    }

    // If an error occurs, return a generic error message
    return AppText.somethingWentWrong;
  }
}
