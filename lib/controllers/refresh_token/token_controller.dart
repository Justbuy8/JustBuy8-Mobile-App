import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class TokenController {
  // Static method to refresh the user's authentication token.
  static refreshAuthToken() async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a GET request to refresh the authentication token with the current token provided in the headers.
    Response response = await ApiManager.getRequest(
      RefreshTokenUrl.refreshToken,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization':
            'Bearer ${userToken}' // Include the current user token in the request headers.
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result, which may contain a new token.
      var result = jsonDecode(response.body);

      return result;
    }
  }
}
