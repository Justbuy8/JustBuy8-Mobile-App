// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Create a class for ChildCategoryProductsController
class ChildCategoryProductsController {
  // Static method to fetch products based on category, subcategory, and child category
  static Future<List<ProductModel>> getProducts({
    page,
    paginateBy,
    categoryId,
    subCategoryId,
    childCategoryId,
  }) async {
    // Create a list to store the products
    List<ProductModel> products = [];

    // Make a POST request to get products based on category, subcategory, and child category
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "child_category_id": childCategoryId,
      },
      ProductsUrl.getProductsByMainCategory,
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
