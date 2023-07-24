import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class SupportController {
  static getSupportData() async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.getRequest(
      SupportUrl.getSupport,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    print(userToken);
    log(userToken.toString());

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static contactUs(body) async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.postRequest(
      body,
      SupportUrl.postContact,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }
}
