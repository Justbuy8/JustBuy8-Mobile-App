// To parse this JSON data, do
//
//     final getCouponsModel = getCouponsModelFromJson(jsonString);

import 'dart:convert';

GetCouponsModel getCouponsModelFromJson(String str) =>
    GetCouponsModel.fromJson(json.decode(str));

String getCouponsModelToJson(GetCouponsModel data) =>
    json.encode(data.toJson());

class GetCouponsModel {
  List<Datum> data;
  bool success;
  String message;
  dynamic extra;

  GetCouponsModel({
    required this.data,
    required this.success,
    required this.message,
    required this.extra,
  });

  factory GetCouponsModel.fromJson(Map<String, dynamic> json) =>
      GetCouponsModel(
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
  int id;
  String couponType;
  String title;
  String code;
  DateTime startDate;
  DateTime expireDate;
  String minPurchase;
  String maxDiscount;
  String discount;
  String discountType;
  String limit;

  Datum({
    required this.id,
    required this.couponType,
    required this.title,
    required this.code,
    required this.startDate,
    required this.expireDate,
    required this.minPurchase,
    required this.maxDiscount,
    required this.discount,
    required this.discountType,
    required this.limit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        couponType: json["coupon_type"],
        title: json["title"],
        code: json["code"],
        startDate: DateTime.parse(json["start_date"]),
        expireDate: DateTime.parse(json["expire_date"]),
        minPurchase: json["min_purchase"],
        maxDiscount: json["max_discount"],
        discount: json["discount"],
        discountType: json["discount_type"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coupon_type": couponType,
        "title": title,
        "code": code,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "expire_date":
            "${expireDate.year.toString().padLeft(4, '0')}-${expireDate.month.toString().padLeft(2, '0')}-${expireDate.day.toString().padLeft(2, '0')}",
        "min_purchase": minPurchase,
        "max_discount": maxDiscount,
        "discount": discount,
        "discount_type": discountType,
        "limit": limit,
      };
}
