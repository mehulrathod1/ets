// To parse this JSON data, do
//
//     final companyContactCustomerModel = companyContactCustomerModelFromJson(jsonString);

import 'dart:convert';

class CompanyContactCustomerModel {
  String status;
  String message;
  Data data;

  CompanyContactCustomerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyContactCustomerModel.fromRawJson(String str) =>
      CompanyContactCustomerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyContactCustomerModel.fromJson(Map<String, dynamic> json) =>
      CompanyContactCustomerModel(
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
  List<Map<String, String>> list;

  Data({
    required this.list,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<Map<String, String>>.from(json["List"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
