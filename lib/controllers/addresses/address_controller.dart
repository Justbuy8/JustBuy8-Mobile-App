import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';

class AddressController {
  static createAddress(body) async {
    Response response = await ApiManager.postRequest(
      body,
      AddressUrl.createAddress,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static getAddress(body) async {
    Response response = await ApiManager.postRequest(
      body,
      AddressUrl.getAddress,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static updateAddress(body) async {
    Response response = await ApiManager.postRequest(
      body,
      AddressUrl.updateAddress,
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
