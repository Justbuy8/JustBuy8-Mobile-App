// ignore_for_file: file_names

// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';
import 'package:justbuyeight/models/categories/SubCategoryModel.dart';

// Create a class for CategoryController
class CategoryController {
  // Static method to fetch top categories
  static Future<List<CategoryModel>> getTopCategories(
    page,
    paginateBy,
  ) async {
    List<CategoryModel> topCategories = [];

    // Make a POST request to get top categories
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      CategoriesUrl.topCategories,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Parse and add each category to the list
        result['Data'].forEach((category) {
          topCategories.add(CategoryModel.fromJson(category));
        });
      } else {
        // If the request was not successful, set the list to empty
        topCategories = [];
      }
    } else {
      // If the response status code is not 200, set the list to empty
      topCategories = [];
    }

    // Return the list of top categories
    return topCategories;
  }

  // Static method to fetch main categories
  static Future<List<CategoryModel>> getMainCategories(
    String page,
    String paginateBy,
    bool random,
  ) async {
    List<CategoryModel> mainCategories = [];

    // Make a POST request to get main categories
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "random": random,
      },
      CategoriesUrl.mainCategories,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;

      // Check if the request was successful
      if (data['Success']) {
        // Parse and add each main category to the list
        data['Data'].forEach((category) {
          mainCategories.add(CategoryModel.fromJson(category));
        });
      } else {
        // If the request was not successful, set the list to empty
        mainCategories = [];
      }
    } else {
      // If the response status code is not 200, set the list to empty
      mainCategories = [];
    }

    // Return the list of main categories
    return mainCategories;
  }

  // Static method to fetch subcategories for a given categoryId
  static Future<List<SubCategoryModel>> getSubCategories(
    int categoryId,
  ) async {
    List<SubCategoryModel> subCategories = [];

    // Make a POST request to get subcategories for the given categoryId
    final response = await ApiManager.postRequest(
      {"CatId": categoryId},
      CategoriesUrl.subCategories,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;

      // Check if the request was successful
      if (data['Success']) {
        // Parse and add each subcategory to the list
        data['Data'].forEach((category) {
          subCategories.add(SubCategoryModel.fromJson(category));
        });
      } else {
        // If the request was not successful, set the list to empty
        subCategories = [];
      }
    } else {
      // If the response status code is not 200, set the list to empty
      subCategories = [];
    }

    // Return the list of subcategories
    return subCategories;
  }
}
