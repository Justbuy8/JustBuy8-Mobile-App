import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/banners/main_banner.dart';

class BannerController {
  static final ApiManager _apiManager = ApiManager();
  static Future<List<MainBanner>> getMainBanners() async {
    List<MainBanner> banners = [];

    try {
      var response = await _apiManager
          .getRequest("${AppUrl.liveBaseUrl}/banners/get-main-banners");
      if (response != null && response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        if (responseBody['Success'] == true) {
          response = responseBody['data'];
          for (var item in response) {
            banners.add(MainBanner.fromJson(item));
          }
        } else {
          throw Exception(responseBody['message']);
        }
      }
    } catch (error) {
      rethrow;
    }
    return banners;
  }
}
