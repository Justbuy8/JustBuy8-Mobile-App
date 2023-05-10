import 'dart:convert';

List<FeaturedProductsModel> featuredProductsModelFromJson(String str) =>
    List<FeaturedProductsModel>.from(
        json.decode(str).map((x) => FeaturedProductsModel.fromJson(x)));

String featuredProductsModelToJson(List<FeaturedProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeaturedProductsModel {
  final int? id;
  final String? name;
  final String? thumbnail;
  final String? unitPrice;
  final String? discount;
  final String? discountType;
  final int? totalRating;

  FeaturedProductsModel({
    this.id,
    this.name,
    this.thumbnail,
    this.unitPrice,
    this.discount,
    this.discountType,
    this.totalRating,
  });

  factory FeaturedProductsModel.fromJson(Map<String, dynamic> json) =>
      FeaturedProductsModel(
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
