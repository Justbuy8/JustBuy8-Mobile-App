import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';

class MyAccountController {
  static getAccountData(userId, userToken) async {
    Response response = await ApiManager.postRequest(
      {
        "UserId": "$userId",
        "Token": "$userToken",
      },
      MyAccountUrl.myAccountUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }
}
