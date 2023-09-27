import 'dart:convert';
import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class CartController {
  // Static method to get the user's cart.
  static getCart() async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to retrieve the user's cart with user authentication.
    Response response = await ApiManager.postRequest(
      {},
      CartUrl.getCartUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to increment the quantity of an item in the cart.
  static incrementInQuantity(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to increment item quantity in the cart with user authentication.
    Response response = await ApiManager.postRequest(
      body,
      CartUrl.incrementUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Print the response body for debugging purposes.
    print(response.body);

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to decrement the quantity of an item in the cart.
  static decrementInQuantity(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to decrement item quantity in the cart with user authentication.
    Response response = await ApiManager.postRequest(
      body,
      CartUrl.decrementUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to delete an item from the cart.
  static deleteCart(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to delete an item from the cart with user authentication.
    Response response = await ApiManager.postRequest(
      body,
      CartUrl.deleteUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }
}
