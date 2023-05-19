// To parse this JSON data, do
//
//     final companyDeleteNoteModel = companyDeleteNoteModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteNoteModel {
  String status;
  String message;
  String data;

  CompanyDeleteNoteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyDeleteNoteModel.fromRawJson(String str) =>
      CompanyDeleteNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteNoteModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteNoteModel(
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
