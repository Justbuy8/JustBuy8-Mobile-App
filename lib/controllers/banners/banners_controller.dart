import 'dart:convert';

import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/banners/main_banner.dart';
import 'package:http/http.dart' as http;

class MainBannerController {
  List<MainBanner> getMainBanners() {
    List<MainBanner> banners = [];

    try {
      http
          .get(
        Uri.parse("${AppUrl.liveBaseUrl}${BannerUrl.getMainBanners}"),
      )
          .then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body) as Map<String, dynamic>;
          if (data['Success'] == true) {
            var bannerData = data['Data'] as List<dynamic>;
            for (var element in bannerData) {
              banners.add(MainBanner.fromJson(element));
            }
          }
        } else {
          banners = [];
        }
      });
    } catch (e) {
      rethrow;
    }

    return banners;
  }
}
