// To parse this JSON data, do
//
//     final companyDepartmentDetailModel = companyDepartmentDetailModelFromJson(jsonString);

import 'dart:convert';

class CompanyDepartmentDetailModel {
  CompanyDepartmentDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<ListData> data;

  factory CompanyDepartmentDetailModel.fromRawJson(String str) =>
      CompanyDepartmentDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDepartmentDetailModel.fromJson(Map<String, dynamic> json) =>
      CompanyDepartmentDetailModel(
        status: json["status"],
        message: json["message"],
        data:
            List<ListData>.from(json["data"].map((x) => ListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ListData {
  ListData({
    required this.id,
    required this.departmentName,
  });

  String id;
  String departmentName;

  factory ListData.fromRawJson(String str) =>
      ListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        id: json["id"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
      };
}
