import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';

class AuthenticationController {
  static getEmailVerification(email) async {
    Response response = await ApiManager.postRequest(
      email,
      AuthUrl.validateEmail,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print("status code ${response.statusCode}");

      var result = jsonDecode(response.body);
      print(result);
      return result;
      //   if (result['Success']) {

      //   } else {
      //     bannerList = [];
      //   }
      // } else {
      //   bannerList = [];
      // }
      // return bannerList;
      // return null;
    }
  }
}
