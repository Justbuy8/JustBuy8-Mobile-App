import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ReviewModel.dart';

class ProductReviewController {
  static Future<List<ReviewModel>> getReviews(int productId) async {
    List<ReviewModel> reviews = [];
    final response = await ApiManager.postRequest(
      {"product_id": productId},
      ProductsUrl.getProductReviews,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        for (var item in result['Data']) {
          reviews.add(ReviewModel.fromJson(item));
        }
      } else {
        reviews;
      }
    } else {
      reviews;
    }
    return reviews;
  }
}
