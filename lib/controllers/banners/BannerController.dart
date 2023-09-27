import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

class BannerController {
  static Future<List<BannerModel>> getBanners(
      {required bool isMainBanner}) async {
    // a list of models that will store our actual data stored in the database.
    List<BannerModel> bannerList = [];

    // hitting api using get request and storing the responce in a variable.
    // this one method is used for two banners i.e main banner and footer banner.
    Response response = await ApiManager.getRequest(
        isMainBanner ? BannerUrl.getMainBanners : BannerUrl.getFooterBanners);
    if (response.statusCode == 200) {
      // 200 status code indicates success, so if we have successfully hitted the banner API
      // then we will parse the json data and store it in our list.
      var result = jsonDecode(response.body);
      if (result['Success']) {
        bannerList = bannerModelFromJson(jsonEncode(result['Data']));
      } else {
        // othewise we will return empty list
        bannerList = [];
      }
    } else {
      bannerList = [];
    }
    // we will return the list
    return bannerList;
  }
}
