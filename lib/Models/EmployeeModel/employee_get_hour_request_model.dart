// To parse this JSON data, do
//
//     final employeeGetHourRequestModel = employeeGetHourRequestModelFromJson(jsonString);

import 'dart:convert';

EmployeeGetHourRequestModel employeeGetHourRequestModelFromJson(String str) => EmployeeGetHourRequestModel.fromJson(json.decode(str));

String employeeGetHourRequestModelToJson(EmployeeGetHourRequestModel data) => json.encode(data.toJson());

class EmployeeGetHourRequestModel {
  EmployeeGetHourRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeGetHourRequestModel.fromJson(Map<String, dynamic> json) => EmployeeGetHourRequestModel(
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
    required this.list,
    required this.paginationInfo,
  });

  List<ListElement> list;
  PaginationInfo paginationInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(json["List"].map((x) => ListElement.fromJson(x))),
        paginationInfo: PaginationInfo.fromJson(json["pagination_info"]),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "pagination_info": paginationInfo.toJson(),
      };
}

class ListElement {
  ListElement({
    required this.employeeId,
    required this.employeeName,
    required this.companyId,
    required this.attendanceDateIn,
    required this.attendanceDateOut,
    required this.inTime,
    required this.outTime,
    required this.message,
    required this.status,
  });

  String employeeId;
  String employeeName;
  String companyId;
  DateTime attendanceDateIn;
  DateTime attendanceDateOut;
  String inTime;
  String outTime;
  String message;
  String status;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        companyId: json["company_id"],
        attendanceDateIn: DateTime.parse(json["attendance_date_in"]),
        attendanceDateOut: DateTime.parse(json["attendance_date_out"]),
        inTime: json["in_time"],
        outTime: json["out_time"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "employee_name": employeeName,
        "company_id": companyId,
        "attendance_date_in": "${attendanceDateIn.year.toString().padLeft(4, '0')}-${attendanceDateIn.month.toString().padLeft(2, '0')}-${attendanceDateIn.day.toString().padLeft(2, '0')}",
        "attendance_date_out": "${attendanceDateOut.year.toString().padLeft(4, '0')}-${attendanceDateOut.month.toString().padLeft(2, '0')}-${attendanceDateOut.day.toString().padLeft(2, '0')}",
        "in_time": inTime,
        "out_time": outTime,
        "message": message,
        "status": status,
      };
}

class PaginationInfo {
  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    required this.totalPages,
  });

  int itemPerPage;
  String pageNumber;
  int totalRows;
  int totalPages;

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
        itemPerPage: json["item_per_page"],
        pageNumber: json["page_number"],
        totalRows: json["total_rows"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "item_per_page": itemPerPage,
        "page_number": pageNumber,
        "total_rows": totalRows,
        "total_pages": totalPages,
      };
}
