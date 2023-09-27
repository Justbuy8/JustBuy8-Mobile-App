// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Create a class for BestProductsController
class BestProductsController {
  // Static method to fetch the best products
  static Future<List<ProductModel>> getBestProducts(
    page,
    paginateBy,
    random,
  ) async {
    // Create a list to store the best products
    List<ProductModel> bestProducts = [];

    // Make a POST request to get the best products
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "random": random,
      },
      ProductsUrl.bestProducts,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Convert the data into a list of ProductModel objects
        bestProducts = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        // If the request was not successful, set the bestProducts list to empty
        bestProducts = [];
      }
    } else {
      // If the response status code is not 200, set the bestProducts list to empty
      bestProducts = [];
    }

    // Return the list of best products
    return bestProducts;
  }
}
