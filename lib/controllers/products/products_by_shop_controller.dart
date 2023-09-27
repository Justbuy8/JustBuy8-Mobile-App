// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Create an abstract class for ProductsByShopController
abstract class ProductsByShopController {
  // Static method to fetch products by shop
  static Future<List<ProductModel>> getProductsByShop(
    int page,
    int paginatedBy,
    int shopId,
  ) async {
    // Create a list to store the products
    List<ProductModel> products = [];

    // Make a POST request to get products by shop
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginatedBy,
        "vendor_id": shopId,
      },
      ShopsUrl.getProductsByShopUrl,
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

    // Return the list of products
    return products;
  }
}
