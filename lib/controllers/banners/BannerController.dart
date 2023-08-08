import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

class BannerController {
  static Future<List<BannerModel>> getBanners(
      {required bool isMainBanner}) async {
    List<BannerModel> bannerList = [];
    Response response = await ApiManager.getRequest(
        isMainBanner ? BannerUrl.getMainBanners : BannerUrl.getFooterBanners);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        bannerList = bannerModelFromJson(jsonEncode(result['Data']));
      } else {
        bannerList = [];
      }
    } else {
      bannerList = [];
    }
    return bannerList;
  }
}
