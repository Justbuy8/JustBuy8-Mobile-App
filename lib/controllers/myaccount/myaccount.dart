import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

class MyAccountController {
  // Static method to get user account data.
  static getAccountData() async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to retrieve user account data with user authentication.
    Response response = await ApiManager.postRequest(
      {},
      MyAccountUrl.myAccountUrl,
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

  // Static method to upload a user's profile image.
  static uploadImage(userToken, file) async {
    // Create a multipart request for uploading an image.
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(MyAccountUrl.updateProfileImage),
    );

    // Define headers for the request.
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    // Add the image file to the request.
    request.files.add(await http.MultipartFile.fromPath('ImageFile', file));

    // Add headers to the request.
    request.headers.addAll(headers);

    // Set the user token in the request fields.
    request.fields['Token'] = userToken!;

    // Send the request and get the response.
    var res = await request.send();

    // Print the response status code for debugging purposes.
    print(res.statusCode);

    // Check if the response status code is 200 (OK).
    if (res.statusCode == 200) {
      // Parse the response JSON and return the result.
      var result = jsonDecode(await res.stream.bytesToString());
      return result;
    }
  }

  // Static method to update user profile data.
  static updateUserData(userBody) async {
    // Fetch the user token from secure storage.
    String? userToken = await UserSecureStorage.fetchToken();

    // Perform a POST request to update user profile data with user authentication.
    Response response = await ApiManager.postRequest(
      userBody,
      MyAccountUrl.updateUserProfileUrl,
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
