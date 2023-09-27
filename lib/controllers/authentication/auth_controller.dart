import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class AuthenticationController {
  // Static method to reset a user's password via email.
  static resetEmail(email, password) async {
    // Perform a POST request to reset the password with email and password parameters.
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

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to verify email with OTP.
  static verifyEmailOtp(email, otp) async {
    // Perform a POST request to verify email with email and OTP parameters.
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

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to get email verification status.
  static getEmailVerification(email) async {
    // Perform a POST request to validate email with email parameter.
    Response response = await ApiManager.postRequest(
      {"email": "$email"},
      AuthUrl.validateEmail,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to send an OTP code via email.
  static sendOtpCode(email) async {
    // Perform a POST request to send an OTP code with email parameter.
    Response response = await ApiManager.postRequest(
      {"email": "$email"},
      AuthUrl.sendOtp,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method for user registration.
  static registration(body) async {
    // Perform a POST request to register a user with the provided body.
    Response response = await ApiManager.postRequest(
      body,
      AuthUrl.registration,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method for user login.
  static login(body) async {
    // Perform a POST request to log in a user with the provided body.
    Response response = await ApiManager.postRequest(
      body,
      AuthUrl.login,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }

  // Static method to register a notification token with user authentication.
  static notificationTokenRegistration(body) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to register a notification token with user authentication.
    Response response = await ApiManager.postRequest(
      body,
      AuthUrl.notificationTokenRoute,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization': 'Bearer ${userToken}'
      },
    );

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(response.body);
      return result;
    }
  }
}
