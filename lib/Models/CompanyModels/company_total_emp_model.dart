// To parse this JSON data, do
//
//     final totalEmployeeModel = totalEmployeeModelFromJson(jsonString);

import 'dart:convert';

TotalEmployeeModel totalEmployeeModelFromJson(String str) =>
    TotalEmployeeModel.fromJson(json.decode(str));

String totalEmployeeModelToJson(TotalEmployeeModel data) =>
    json.encode(data.toJson());

class TotalEmployeeModel {
  TotalEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory TotalEmployeeModel.fromJson(Map<String, dynamic> json) =>
      TotalEmployeeModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
