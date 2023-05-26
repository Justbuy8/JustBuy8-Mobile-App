// ignore_for_file: file_names

import 'dart:convert';

List<ProductModel> productsModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productsModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int? id;
  final String? name;
  final String? thumbnail;
  final String? unitPrice;
  final String? discount;
  final String? discountType;
  final String? totalRating;

  ProductModel({
    this.id,
    this.name,
    this.thumbnail,
    this.unitPrice,
    this.discount,
    this.discountType,
    this.totalRating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        unitPrice: json["unit_price"],
        discount: json["discount"],
        discountType: json["discount_type"],
        totalRating: json["total_rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "unit_price": unitPrice,
        "discount": discount,
        "discount_type": discountType,
        "total_rating": totalRating,
      };
}
