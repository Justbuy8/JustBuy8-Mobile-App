// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  List<Datum> data;
  bool success;
  String message;
  dynamic extra;

  AddressModel({
    required this.data,
    required this.success,
    required this.message,
    this.extra,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
  String contactPersonName;
  String addressType;
  String address;
  String city;
  String zip;
  String phone;
  String isBilling;

  Datum({
    required this.id,
    required this.contactPersonName,
    required this.addressType,
    required this.address,
    required this.city,
    required this.zip,
    required this.phone,
    required this.isBilling,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        contactPersonName: json["contact_person_name"],
        addressType: json["address_type"],
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        phone: json["phone"],
        isBilling: json["is_billing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_person_name": contactPersonName,
        "address_type": addressType,
        "address": address,
        "city": city,
        "zip": zip,
        "phone": phone,
        "is_billing": isBilling,
      };
}
