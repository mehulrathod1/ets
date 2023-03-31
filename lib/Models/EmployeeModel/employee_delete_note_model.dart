// To parse this JSON data, do
//
//     final employeeDeleteNoteModel = employeeDeleteNoteModelFromJson(jsonString);

import 'dart:convert';

class EmployeeDeleteNoteModel {
  EmployeeDeleteNoteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory EmployeeDeleteNoteModel.fromRawJson(String str) =>
      EmployeeDeleteNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeDeleteNoteModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDeleteNoteModel(
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
