// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Create a class for NewArrivalController
class NewArrivalController {
  // Static method to fetch new arrivals based on category
  static Future<List<ProductModel>> getNewArrivals(
      page, paginateBy, categoryId) async {
    // Create a list to store the new arrivals
    List<ProductModel> newArrivals = [];

    // Make a POST request to get new arrivals based on the category
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "category_id": categoryId,
      },
      ProductsUrl.newArrivals,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Convert the data into a list of ProductModel objects
        newArrivals = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        // If the request was not successful, set the newArrivals list to empty
        newArrivals = [];
      }
    } else {
      // If the response status code is not 200, set the newArrivals list to empty
      newArrivals = [];
    }

    // Return the list of new arrivals
    return newArrivals;
  }
}
