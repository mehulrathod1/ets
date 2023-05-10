// To parse this JSON data, do
//
//     final companyEmployeeDetailModel = companyEmployeeDetailModelFromJson(jsonString);

import 'dart:convert';

class CompanyEmployeeDetailModel {
  CompanyEmployeeDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyEmployeeDetailModel.fromRawJson(String str) =>
      CompanyEmployeeDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyEmployeeDetailModel.fromJson(Map<String, dynamic> json) =>
      CompanyEmployeeDetailModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.departmentId,
    required this.employeeName,
    required this.email,
    required this.profileImg,
  });

  String id;
  String companyId;
  String companyName;
  String departmentId;
  String employeeName;
  String email;
  String profileImg;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        departmentId: json["department_id"],
        employeeName: json["employee_name"],
        email: json["email"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "company_name": companyName,
        "department_id": departmentId,
        "employee_name": employeeName,
        "email": email,
        "profile_img": profileImg,
      };
}
