// To parse this JSON data, do
//
//     final supportModel = supportModelFromJson(jsonString);

import 'dart:convert';

SupportModel supportModelFromJson(String str) =>
    SupportModel.fromJson(json.decode(str));

String supportModelToJson(SupportModel data) => json.encode(data.toJson());

class SupportModel {
  List<Datum> data;
  bool success;
  String message;
  dynamic extra;

  SupportModel({
    required this.data,
    required this.success,
    required this.message,
    this.extra,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
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
  String companyName;
  String email;
  String address;
  String phone;

  Datum({
    required this.companyName,
    required this.email,
    required this.address,
    required this.phone,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        companyName: json["company_name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "email": email,
        "address": address,
        "phone": phone,
      };
}
