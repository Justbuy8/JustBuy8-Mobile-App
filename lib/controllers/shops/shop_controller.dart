import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/shop/Shop.dart';

class ShopController {
  static Future<List<Shop>> getAllShops(page, paginateBy) async {
    List<Shop> shops = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
      },
      ShopsUrl.getAllShops,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        final shopsList = result['Data'] as List;
        shops = shopsList.map((e) => Shop.fromJson(e)).toList();
      } else {
        shops = [];
      }
    } else {
      shops = [];
    }
    return shops;
  }
}
