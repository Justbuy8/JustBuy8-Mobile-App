import 'dart:convert';

import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class NewArrivalController {
  static Future<List<ProductModel>> getNewArrivals(
      page, paginateBy, categoryId) async {
    List<ProductModel> newArrivals = [];

    final response = await ApiManager.postRequest(
      {
        "page": page,
        "paginate_by": paginateBy,
        "category_id": categoryId,
      },
      ProductsUrl.newArrivals,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Success']) {
        newArrivals = productsModelFromJson(jsonEncode(result['Data']));
      } else {
        newArrivals = [];
      }
    } else {
      newArrivals = [];
    }
    return newArrivals;
  }
}
