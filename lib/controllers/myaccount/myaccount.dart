import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:http/http.dart' as http;

class MyAccountController {
  static getAccountData(userId, userToken) async {
    Response response = await ApiManager.postRequest(
      {
        "UserId": "$userId",
        "Token": "$userToken",
      },
      MyAccountUrl.myAccountUrl,
      headers: {
        "content-type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static uploadImage(userId, userToken, file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(MyAccountUrl.updateProfileImage),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(await http.MultipartFile.fromPath('ImageFile', file));

    request.headers.addAll(headers);

    request.fields['UserId'] = userId!;
    request.fields['Token'] = userToken!;

    var res = await request.send();

    if (res.statusCode == 200) {
      var result = jsonDecode(await res.stream.bytesToString());
      return result;
    }
  }
}
