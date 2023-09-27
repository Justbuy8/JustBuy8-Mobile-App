import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class SupportController {
  // Static method to get support-related data.
  static getSupportData() async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a GET request to retrieve support-related data with user authentication.
    Response response = await ApiManager.getRequest(
      SupportUrl.getSupport,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Print and log the user token for debugging purposes.
    print(userToken);
    log(userToken.toString());

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to contact support with a user message.
  static contactUs(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to contact support with the user's message and user authentication.
    Response response = await ApiManager.postRequest(
      body,
      SupportUrl.postContact,
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
