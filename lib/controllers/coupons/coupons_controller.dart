// ignore_for_file: unused_import

import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponsController {
  static getCoupons() async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.getRequest(
      CoupinsUrl.couponsUrl,
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
