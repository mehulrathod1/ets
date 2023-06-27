// To parse this JSON data, do
//
//     final employeeGetEventModel = employeeGetEventModelFromJson(jsonString);

import 'dart:convert';

class EmployeeGetEventModel {
  String status;
  String message;
  Data data;

  EmployeeGetEventModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeGetEventModel.fromRawJson(String str) =>
      EmployeeGetEventModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeGetEventModel.fromJson(Map<String, dynamic> json) =>
      EmployeeGetEventModel(
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
  List<ListElement1> list;
  PaginationInfo paginationInfo;

  Data({
    required this.list,
    required this.paginationInfo,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement1>.from(
            json["List"].map((x) => ListElement1.fromJson(x))),
        paginationInfo: PaginationInfo.fromJson(json["pagination_info"]),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "pagination_info": paginationInfo.toJson(),
      };
}

class ListElement1 {
  String eventId;
  String companyId;
  String employeeId;
  String eventName;
  String eventDescription;
  String dueDate;
  String startDate;

  ListElement1({
    required this.eventId,
    required this.companyId,
    required this.employeeId,
    required this.eventName,
    required this.eventDescription,
    required this.dueDate,
    required this.startDate,
  });

  factory ListElement1.fromRawJson(String str) =>
      ListElement1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement1.fromJson(Map<String, dynamic> json) => ListElement1(
        eventId: json["event_id"],
        companyId: json["company_id"],
        employeeId: json["employee_id"],
        eventName: json["event_name"],
        eventDescription: json["event_description"],
        dueDate: json["due_date"],
        startDate: json["start_date"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "company_id": companyId,
        "employee_id": employeeId,
        "event_name": eventName,
        "event_description": eventDescription,
        "due_date": dueDate,
        "start_date": startDate
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
