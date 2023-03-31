// To parse this JSON data, do
//
//     final getCompanyDepartmentModel = getCompanyDepartmentModelFromJson(jsonString);

import 'dart:convert';

  GetCompanyDepartmentModel getCompanyDepartmentModelFromJson(String str) =>
    GetCompanyDepartmentModel.fromJson(json.decode(str));

String getCompanyDepartmentModelToJson(GetCompanyDepartmentModel data) =>
    json.encode(data.toJson());

class GetCompanyDepartmentModel {
  GetCompanyDepartmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GetCompanyDepartmentModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyDepartmentModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.departmentName,
  });

  String id;
  String departmentName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
      };
}
