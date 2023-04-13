// To parse this JSON data, do
//
//     final companyYearlyReportModel = companyYearlyReportModelFromJson(jsonString);

import 'dart:convert';

class CompanyYearlyReportModel {
  CompanyYearlyReportModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyYearlyReportModel.fromRawJson(String str) =>
      CompanyYearlyReportModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyYearlyReportModel.fromJson(Map<String, dynamic> json) =>
      CompanyYearlyReportModel(
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

  List<ListData> list;
  PaginationInfo paginationInfo;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list:
            List<ListData>.from(json["List"].map((x) => ListData.fromJson(x))),
        paginationInfo: PaginationInfo.fromJson(json["pagination_info"]),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "pagination_info": paginationInfo.toJson(),
      };
}

class ListData {
  ListData({
    required this.empId,
    required this.empName,
    required this.year,
    required this.totalHours,
    required this.breakHours,
  });

  String empId;
  String empName;
  dynamic year;
  String totalHours;
  String breakHours;

  factory ListData.fromRawJson(String str) =>
      ListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        empId: json["emp_id"],
        empName: json["emp_name"],
        year: json["year"],
        totalHours: json["Total_hours"],
        breakHours: json["Break_hours"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "emp_name": empName,
        "year": year,
        "Total_hours": totalHours,
        "Break_hours": breakHours,
      };
}

class PaginationInfo {
  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    this.totalPages,
  });

  int itemPerPage;
  int pageNumber;
  int totalRows;
  dynamic totalPages;

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
