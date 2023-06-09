// To parse this JSON data, do
//
//     final companyHourRequestModel = companyHourRequestModelFromJson(jsonString);

import 'dart:convert';

class CompanyHourRequestModel {
  String status;
  String message;
  Data data;

  CompanyHourRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyHourRequestModel.fromRawJson(String str) =>
      CompanyHourRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyHourRequestModel.fromJson(Map<String, dynamic> json) =>
      CompanyHourRequestModel(
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
  String employeeName;
  String companyId;
  DateTime attendanceDateIn;
  String inTime;
  DateTime attendanceDateOut;
  String outTime;
  String message;
  String status;
  DateTime createAt;

  ListElement({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.companyId,
    required this.attendanceDateIn,
    required this.inTime,
    required this.attendanceDateOut,
    required this.outTime,
    required this.message,
    required this.status,
    required this.createAt,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        companyId: json["company_id"],
        attendanceDateIn: DateTime.parse(json["attendance_date_in"]),
        inTime: json["in_time"],
        attendanceDateOut: DateTime.parse(json["attendance_date_out"]),
        outTime: json["out_time"],
        message: json["message"],
        status: json["status"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "employee_name": employeeName,
        "company_id": companyId,
        "attendance_date_in":
            "${attendanceDateIn.year.toString().padLeft(4, '0')}-${attendanceDateIn.month.toString().padLeft(2, '0')}-${attendanceDateIn.day.toString().padLeft(2, '0')}",
        "in_time": inTime,
        "attendance_date_out":
            "${attendanceDateOut.year.toString().padLeft(4, '0')}-${attendanceDateOut.month.toString().padLeft(2, '0')}-${attendanceDateOut.day.toString().padLeft(2, '0')}",
        "out_time": outTime,
        "message": message,
        "status": status,
        "create_at": createAt.toIso8601String(),
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
