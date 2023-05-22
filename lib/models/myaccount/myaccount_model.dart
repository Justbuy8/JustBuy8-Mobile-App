// To parse this JSON data, do
//
//     final myAccountModel = myAccountModelFromJson(jsonString);

import 'dart:convert';

MyAccountModel myAccountModelFromJson(String str) =>
    MyAccountModel.fromJson(json.decode(str));

String myAccountModelToJson(MyAccountModel data) => json.encode(data.toJson());

class MyAccountModel {
  Data data;
  bool success;
  String message;
  dynamic extra;

  MyAccountModel({
    required this.data,
    required this.success,
    required this.message,
    this.extra,
  });

  factory MyAccountModel.fromJson(Map<String, dynamic> json) => MyAccountModel(
        data: Data.fromJson(json["Data"]),
        success: json["Success"],
        message: json["Message"],
        extra: json["Extra"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Success": success,
        "Message": message,
        "Extra": extra,
      };
}

class Data {
  String firstName;
  String lastName;
  String email;
  String phone;
  String profileImage;

  Data({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profileImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "profileImage": profileImage,
      };
}
