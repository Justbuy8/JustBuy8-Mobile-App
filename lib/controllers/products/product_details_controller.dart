// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductDetailsModel.dart';

// Create a class for ProductDetailsController
class ProductDetailsController {
  // Static method to fetch product details based on productId
  static Future<ProductDetailsModel?> getProducts(productId) async {
    // Declare a variable to store the product details (nullable)
    ProductDetailsModel? products;

    // Make a POST request to get product details based on productId
    final response = await ApiManager.postRequest(
      {
        "product_id": productId,
      },
      ProductsUrl.getProductDetails,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Parse the product details and assign them to the 'products' variable
        products = ProductDetailsModel.fromJson(result['Data']);
      } else {
        // If the request was not successful, leave 'products' as null
        products;
      }
    } else {
      // If the response status code is not 200, leave 'products' as null
      products;
    }

    // Return the product details (nullable)
    return products;
  }
}
