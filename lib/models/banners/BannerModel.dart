// ignore_for_file: file_names

import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(
    json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  int id;
  String imageLink;
  String url;
  String resourceType;
  String resourceId;

  BannerModel({
    required this.id,
    required this.imageLink,
    required this.url,
    required this.resourceType,
    required this.resourceId,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["Id"],
        imageLink: json["Image Link"],
        url: json["Url"],
        resourceType: json["Resource Type"],
        resourceId: json["Resource id"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Image Link": imageLink,
        "Url": url,
        "Resource Type": resourceType,
        "Resource id": resourceId,
      };
}
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
