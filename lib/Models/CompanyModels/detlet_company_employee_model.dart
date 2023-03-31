// To parse this JSON data, do
//
//     final deleteCompanyEmployeeModel = deleteCompanyEmployeeModelFromJson(jsonString);

import 'dart:convert';

DeleteCompanyEmployeeModel deleteCompanyEmployeeModelFromJson(String str) =>
    DeleteCompanyEmployeeModel.fromJson(json.decode(str));

String deleteCompanyEmployeeModelToJson(DeleteCompanyEmployeeModel data) =>
    json.encode(data.toJson());

class DeleteCompanyEmployeeModel {
  DeleteCompanyEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory DeleteCompanyEmployeeModel.fromJson(Map<String, dynamic> json) =>
      DeleteCompanyEmployeeModel(
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
