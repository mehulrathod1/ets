// To parse this JSON data, do
//
//     final companyEditAttendanceListModel = companyEditAttendanceListModelFromJson(jsonString);

import 'dart:convert';

class CompanyEditAttendanceListModel {
  String status;
  String message;
  Data data;

  CompanyEditAttendanceListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyEditAttendanceListModel.fromRawJson(String str) =>
      CompanyEditAttendanceListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyEditAttendanceListModel.fromJson(Map<String, dynamic> json) =>
      CompanyEditAttendanceListModel(
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
  List<ListElement> list;
  PaginationInfo paginationInfo;

  Data({
    required this.list,
    required this.paginationInfo,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["List"].map((x) => ListElement.fromJson(x))),
        paginationInfo: PaginationInfo.fromJson(json["pagination_info"]),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "pagination_info": paginationInfo.toJson(),
      };
}

class ListElement {
  String id;
  String employeeId;
  String empName;
  String companyName;
  String attendanceDate;
  String totalHrs;
  String breakHours;
  String attendanceInTime;
  String attendanceOutTime;
  String locationOut;

  ListElement({
    required this.id,
    required this.employeeId,
    required this.empName,
    required this.companyName,
    required this.attendanceDate,
    required this.totalHrs,
    required this.breakHours,
    required this.attendanceInTime,
    required this.attendanceOutTime,
    required this.locationOut,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        employeeId: json["employee_id"],
        empName: json["emp_name"],
        companyName: json["company_name"],
        attendanceDate: json["attendance_date"],
        totalHrs: json["total_hrs"],
        breakHours: json["Break_hours"],
        attendanceInTime: json["attendance_In_time"],
        attendanceOutTime: json["attendance_Out_time"],
        locationOut: json["location_Out"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "emp_name": empName,
        "company_name": companyName,
        "attendance_date": attendanceDate,
        "total_hrs": totalHrs,
        "Break_hours": breakHours,
        "attendance_In_time": attendanceInTime,
        "attendance_Out_time": attendanceOutTime,
        "location_Out": locationOut,
      };
}

class PaginationInfo {
  int itemPerPage;
  int pageNumber;
  int totalRows;
  int totalPages;

  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    required this.totalPages,
  });

  factory PaginationInfo.fromRawJson(String str) =>
      PaginationInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
