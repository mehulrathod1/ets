// To parse this JSON data, do
//
//     final getCompanyDepartmentModel = getCompanyDepartmentModelFromJson(jsonString);

import 'dart:convert';

class GetCompanyDepartmentModel {
  GetCompanyDepartmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GetCompanyDepartmentModel.fromRawJson(String str) =>
      GetCompanyDepartmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
    required this.companyId,
    required this.companyName,
  });

  String id;
  String departmentName;
  String companyId;
  String companyName;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        departmentName: json["department_name"],
        companyId: json["company_id"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "company_id": companyId,
        "company_name": companyName,
      };
}
