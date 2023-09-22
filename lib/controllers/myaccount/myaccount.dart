import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:justbuyeight/utils/secure_storage.dart';

class MyAccountController {
  static getAccountData() async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.postRequest(
      {},
      MyAccountUrl.myAccountUrl,
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

  static uploadImage(userToken, file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(MyAccountUrl.updateProfileImage),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(await http.MultipartFile.fromPath('ImageFile', file));

    request.headers.addAll(headers);

    request.fields['Token'] = userToken!;

    var res = await request.send();
    print(res.statusCode);

    if (res.statusCode == 200) {
      var result = jsonDecode(await res.stream.bytesToString());
      return result;
    }
  }

  static updateUserData(userBody) async {
    String? userToken = await UserSecureStorage.fetchToken();
    Response response = await ApiManager.postRequest(
      userBody,
      MyAccountUrl.updateUserProfileUrl,
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
