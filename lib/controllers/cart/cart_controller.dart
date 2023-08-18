import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class CartController {
  static getCart() async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.postRequest(
      {},
      CartUrl.getCartUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static incrementInQuantity(body) async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.postRequest(
      body,
      CartUrl.incrementUrl,
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

  static decrementInQuantity(body) async {
    String? userToken = await UserSecureStorage.fetchToken();
    print(body);
    Response response = await ApiManager.postRequest(
      body,
      CartUrl.decrementUrl,
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
