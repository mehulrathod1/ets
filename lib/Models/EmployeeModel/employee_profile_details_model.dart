import 'dart:convert';

class EmployeeProfileDetailsModel {
  EmployeeProfileDetailsModel({required this.status, required this.message, required this.data});

  String status;
  String message;
  Data data;

  factory EmployeeProfileDetailsModel.fromRawJson(String str) => EmployeeProfileDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeProfileDetailsModel.fromJson(Map<String, dynamic> json) => EmployeeProfileDetailsModel(status: json['status'], message: json['message'], data: Data.fromJson(json['data']));

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String companyId;
  String companyName;
  String departmentId;
  String departmentName;
  String employeeName;
  String email;
  String username;
  String profileImg;

  Data({required this.companyId, required this.companyName, required this.departmentId, required this.departmentName, required this.employeeName, required this.email, required this.username, required this.profileImg});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(companyId: json['company_id'], companyName: json['company_name'], departmentId: json['department_id'], departmentName: json['department_name'], employeeName: json['employee_name'], email: json['email'], username: json['username'], profileImg: json['profile_img']);

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_name": companyName,
        "department_id": departmentId,
        "department_name": departmentName,
        "employee_name": employeeName,
        "email": email,
        "username": username,
        "profile_img": profileImg,
      };
}
