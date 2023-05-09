// To parse this JSON data, do
//
//     final companyAddNoteModel = companyAddNoteModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddNoteModel {
  String status;
  String message;
  int data;

  CompanyAddNoteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddNoteModel.fromRawJson(String str) =>
      CompanyAddNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddNoteModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddNoteModel(
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
