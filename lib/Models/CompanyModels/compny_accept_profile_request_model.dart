// To parse this JSON data, do
//
//     final acceptProfileChangeModel = acceptProfileChangeModelFromJson(jsonString);

import 'dart:convert';

class AcceptProfileChangeModel {
  String status;
  String message;
  String data;

  AcceptProfileChangeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AcceptProfileChangeModel.fromRawJson(String str) =>
      AcceptProfileChangeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AcceptProfileChangeModel.fromJson(Map<String, dynamic> json) =>
      AcceptProfileChangeModel(
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
