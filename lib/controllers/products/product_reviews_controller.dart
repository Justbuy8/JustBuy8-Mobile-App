// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ReviewModel.dart';

// Create a class for ProductReviewController
class ProductReviewController {
  // Static method to fetch reviews for a given productId
  static Future<List<ReviewModel>> getReviews(int productId) async {
    // Create a list to store the reviews
    List<ReviewModel> reviews = [];

    // Make a POST request to get reviews for the specified productId
    final response = await ApiManager.postRequest(
      {"product_id": productId},
      ProductsUrl.getProductReviews,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Iterate through the review data and parse each item into a ReviewModel
        for (var item in result['Data']) {
          reviews.add(ReviewModel.fromJson(item));
        }
      } else {
        // If the request was not successful, leave 'reviews' as an empty list
        reviews;
      }
    } else {
      // If the response status code is not 200, leave 'reviews' as an empty list
      reviews;
    }

    // Return the list of reviews
    return reviews;
  }
}
