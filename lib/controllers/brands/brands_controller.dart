import 'dart:convert';
import 'dart:developer';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';

class BrandsController {
  static Future<List<BrandsModel>> getBrands(
    page,
    paginateBy,
    random,
  ) async {
    List<BrandsModel> brands = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "random": random,
      },
      BrandsUrl.brands,
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        result['Data'].forEach((brand) {
          brands.add(BrandsModel.fromJson(brand));
        });
      } else {
        brands = [];
      }
    } else {
      brands = [];
    }
    return brands;
  }
}
