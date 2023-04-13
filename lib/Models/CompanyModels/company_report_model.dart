// To parse this JSON data, do
//
//     final companyReportModel = companyReportModelFromJson(jsonString);

import 'dart:convert';

class CompanyReportModel {
  CompanyReportModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyReportModel.fromRawJson(String str) =>
      CompanyReportModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyReportModel.fromJson(Map<String, dynamic> json) =>
      CompanyReportModel(
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
  ListElement({
    required this.id,
    required this.employeeName,
    required this.month,
    required this.totalHrs,
    required this.breakHrs,
  });

  String id;
  String employeeName;
  Month month;
  String totalHrs;
  String breakHrs;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        employeeName: json["employee_name"],
        month: monthValues.map[json["Month"]]!,
        totalHrs: json["total_hrs"],
        breakHrs: json["break_hrs"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "Month": monthValues.reverse[month],
        "total_hrs": totalHrs,
        "break_hrs": breakHrs,
      };
}

enum Month { DECEMBER_1, OCTOBER_2022, SEPTEMBER_2022, AUGUST_2022 }

final monthValues = EnumValues({
  "August-2022": Month.AUGUST_2022,
  "December--1": Month.DECEMBER_1,
  "October-2022": Month.OCTOBER_2022,
  "September-2022": Month.SEPTEMBER_2022
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
