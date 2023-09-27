// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Create a class for SearchProductsController
class SearchProductsController {
  // Static method to fetch products based on search criteria
  static Future<List<ProductModel>> getProducts(
    String query,
    page,
    paginateBy, {
    String? method,
    String? category,
    num? startingPrice,
    num? endingPrice,
    String? totalRatings,
  }) async {
    // Create a list to store the searched products
    List<ProductModel> searchedProducts = [];

    // Print search criteria for debugging (optional)
    print("$category $method $startingPrice $endingPrice $totalRatings");

    // Make a POST request to search for products based on the criteria
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "query": query,
        "method": method,
        "category": category,
        "starting_price": startingPrice,
        "ending_price": endingPrice,
        "total_ratings": totalRatings,
      },
      ProductsUrl.searchProducts,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Convert the data into a list of ProductModel objects
        searchedProducts = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        // If the request was not successful, set the searchedProducts list to empty
        searchedProducts = [];
      }
    } else {
      // If the response status code is not 200, set the searchedProducts list to empty
      searchedProducts = [];
    }

    // Return the list of searched products
    return searchedProducts;
  }
}
