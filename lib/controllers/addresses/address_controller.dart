// ignore_for_file: unused_import

import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class AddressController {
  // Static method to create a new address.
  static createAddress(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to create an address and include user authentication.
    Response response = await ApiManager.postRequest(
      body,
      AddressUrl.createAddress,
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

  // Static method to get user addresses.
  static getAddress() async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to get addresses and include user authentication.
    Response response = await ApiManager.postRequest(
      {},
      AddressUrl.getAddress,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Log the response for debugging purposes.
    log(response.body);

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to update an address.
  static updateAddress(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to update an address and include user authentication.
    Response response = await ApiManager.postRequest(
      body,
      AddressUrl.updateAddress,
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

  // Static method to delete an address.
  static deleteAddress(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to delete an address and include user authentication.
    Response response = await ApiManager.postRequest(
      body,
      AddressUrl.deleteAddress,
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
