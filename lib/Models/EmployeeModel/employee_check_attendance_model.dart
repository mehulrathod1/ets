// To parse this JSON data, do
//
//     final employeeCheckAtttendanceModel = employeeCheckAtttendanceModelFromJson(jsonString);

import 'dart:convert';

class EmployeeCheckAttendanceModel {
  String status;
  String message;
  Data data;

  EmployeeCheckAttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeCheckAttendanceModel.fromRawJson(String str) =>
      EmployeeCheckAttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeCheckAttendanceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeCheckAttendanceModel(
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
  int attendanceStatus;

  Data({
    required this.attendanceStatus,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attendanceStatus: json["attendance_status"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_status": attendanceStatus,
      };
}
