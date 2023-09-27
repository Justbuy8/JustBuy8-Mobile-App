import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';

class BrandsController {
  static Future<List<BrandsModel>> getBrands(page, paginateBy, random) async {
    /*
      @ A function that will be used to fetch all the brands stored in the 
      database using API.

      If we are passed to call the API and we get 200 status code, we will 
      return the list of brands.
    */
    List<BrandsModel> brands = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "random": random,
      },
      BrandsUrl.brands,
    );
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
