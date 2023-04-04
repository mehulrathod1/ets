// To parse this JSON data, do
//
//     final salesDeleteAgentModel = salesDeleteAgentModelFromJson(jsonString);

import 'dart:convert';

class SalesDeleteAgentModel {
  SalesDeleteAgentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory SalesDeleteAgentModel.fromRawJson(String str) =>
      SalesDeleteAgentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesDeleteAgentModel.fromJson(Map<String, dynamic> json) =>
      SalesDeleteAgentModel(
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
