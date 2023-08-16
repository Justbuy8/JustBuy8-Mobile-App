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
}
