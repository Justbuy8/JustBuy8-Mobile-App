// ignore_for_file: unused_import

import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponsController {
  // Static method to get the available coupons for the user.
  static getCoupons() async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a GET request to retrieve available coupons with user authentication.
    Response response = await ApiManager.getRequest(
      CoupinsUrl.couponsUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Log the response body for debugging purposes.
    log(response.body);

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }
}
