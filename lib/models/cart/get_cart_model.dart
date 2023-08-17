// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  List<Datum> data;
  bool success;
  String message;
  dynamic extra;

  GetCartModel({
    required this.data,
    required this.success,
    required this.message,
    required this.extra,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        success: json["Success"],
        message: json["Message"],
        extra: json["Extra"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Success": success,
        "Message": message,
        "Extra": extra,
      };
}

class Datum {
  int cartId;
  String productId;
  String productName;
  String thumbnail;
  int price;
  int shippingCost;
  String quantity;
  Variation? variation;
  String? colorCode;
  int discount;
  int tax;

  Datum({
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.thumbnail,
    required this.price,
    required this.shippingCost,
    required this.quantity,
    required this.variation,
    required this.colorCode,
    required this.discount,
    required this.tax,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        cartId: json["cart_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        shippingCost: json["shipping_cost"],
        quantity: json["quantity"],
        variation: json["variation"] == null
            ? null
            : Variation.fromJson(json["variation"]),
        colorCode: json["color_code"],
        discount: json["discount"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "product_id": productId,
        "product_name": productName,
        "thumbnail": thumbnail,
        "price": price,
        "shipping_cost": shippingCost,
        "quantity": quantity,
        "variation": variation?.toJson(),
        "color_code": colorCode,
        "discount": discount,
        "tax": tax,
      };
}

class Variation {
  String color;
  String bagType;
  String? size;

  Variation({
    required this.color,
    required this.bagType,
    this.size,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        color: json["color"],
        bagType: json["BagType"],
        size: json["Size"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "BagType": bagType,
        "Size": size,
      };
}
