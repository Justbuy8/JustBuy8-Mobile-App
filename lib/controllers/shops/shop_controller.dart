// Import necessary libraries and files
import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/shop/Shop.dart';
import 'package:justbuyeight/models/shop/ShopDetailsModel.dart';

// Create a class for ShopController
class ShopController {
  // Static method to fetch all shops
  static Future<List<Shop>> getAllShops(page, paginateBy) async {
    // Create a list to store all shops
    List<Shop> shops = [];

    // Make a POST request to fetch all shops
    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      ShopsUrl.getAllShops,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Convert the data into a list of Shop objects
        final shopsList = result['Data'] as List;
        shops = shopsList.map((e) => Shop.fromJson(e)).toList();
      } else {
        // If the request was not successful, set the shops list to empty
        shops = [];
      }
    } else {
      // If the response status code is not 200, set the shops list to empty
      shops = [];
    }

    // Return the list of all shops
    return shops;
  }

  // Static method to fetch new shops
  static Future<List<Shop>> getNewShops() async {
    // Create a list to store new shops
    List<Shop> shops = [];

    // Make a GET request to fetch new shops
    final response = await ApiManager.getRequest(
      ShopsUrl.newShops,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Convert the data into a list of Shop objects
        final shopsList = result['Data'] as List;
        shops = shopsList.map((e) => Shop.fromJson(e)).toList();
      } else {
        // If the request was not successful, set the shops list to empty
        shops = [];
      }
    } else {
      // If the response status code is not 200, set the shops list to empty
      shops = [];
    }

    // Return the list of new shops
    return shops;
  }

  // Static method to fetch shop details for a given shopId
  static Future<ShopDetailsModel> getShopDetails(int shopId) async {
    // Create an instance of ShopDetailsModel to store shop details
    ShopDetailsModel shop = ShopDetailsModel();

    // Make a POST request to fetch shop details for the specified shopId
    final response = await ApiManager.postRequest(
      {
        "vendor_id": shopId,
      },
      ShopsUrl.getShopDetails,
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      // Check if the request was successful
      if (result['Success']) {
        // Parse the shop details and assign them to the 'shop' variable
        shop = ShopDetailsModel.fromJson(result['Data'][0]);
      } else {
        // If the request was not successful, leave 'shop' as an empty ShopDetailsModel
        shop = ShopDetailsModel();
      }
    } else {
      // If the response status code is not 200, leave 'shop' as an empty ShopDetailsModel
      shop = ShopDetailsModel();
    }

    // Return the shop details
    return shop;
  }
}
