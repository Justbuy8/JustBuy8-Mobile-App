import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class AuthenticationController {
  static resetEmail(email, password) async {
    Response response = await ApiManager.postRequest(
      {
        "email": "$email",
        "password": "$password",
      },
      AuthUrl.resetPassword,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static verifyEmailOtp(email, otp) async {
    Response response = await ApiManager.postRequest(
      {
        "email": "$email",
        "token": "$otp",
      },
      AuthUrl.verifyEmail,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static getEmailVerification(email) async {
    Response response = await ApiManager.postRequest(
      {"email": "$email"},
      AuthUrl.validateEmail,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static sendOtpCode(email) async {
    Response response = await ApiManager.postRequest(
      {"email": "$email"},
      AuthUrl.sendOtp,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static registration(body) async {
    Response response = await ApiManager.postRequest(
      body,
      AuthUrl.registration,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static login(body) async {
    Response response = await ApiManager.postRequest(
      body,
      AuthUrl.login,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static notificationTokenRegistration(body) async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.postRequest(
      body,
      AuthUrl.notificationTokenRoute,
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
