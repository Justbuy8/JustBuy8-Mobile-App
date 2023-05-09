import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';

class AuthenticationController {
  static getEmailVerification(email) async {
    Response response = await ApiManager.postRequest(
      {"email": "$email"},
      AuthUrl.validateEmail,
      {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }
}
