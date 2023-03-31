// To parse this JSON data, do
//
//     final salesLoginModel = salesLoginModelFromJson(jsonString);

import 'dart:convert';

class SalesLoginModel {
  SalesLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory SalesLoginModel.fromRawJson(String str) =>
      SalesLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesLoginModel.fromJson(Map<String, dynamic> json) =>
      SalesLoginModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.message,
    required this.token,
    required this.isAgency,
    required this.id,
    required this.name,
  });

  String message;
  String token;
  String isAgency;
  String id;
  String name;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        token: json["token"],
        isAgency: json["is_agency"],
        id: json["id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "is_agency": isAgency,
        "id": id,
        "Name": name,
      };
}
