// To parse this JSON data, do
//
//     final getCompanyEmployeeModel = getCompanyEmployeeModelFromJson(jsonString);

import 'dart:convert';

class GetCompanyEmployeeModel {
  GetCompanyEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory GetCompanyEmployeeModel.fromRawJson(String str) =>
      GetCompanyEmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCompanyEmployeeModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyEmployeeModel(
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
    required this.employeeId,
    required this.email,
    required this.employeeName,
    required this.department,
    this.totalHrs,
    required this.viewAttendance,
    required this.editEmployee,
    required this.deleteEmployee,
    required this.viewLiveLocationEmployee,
    required this.sendLiveLocationRequest,
    required this.callForAttendance,
    required this.otherOptions,
  });

  String employeeId;
  String email;
  String employeeName;
  String? department;
  dynamic totalHrs;
  CallForAttendance viewAttendance;
  CallForAttendance editEmployee;
  CallForAttendance deleteEmployee;
  CallForAttendance viewLiveLocationEmployee;
  CallForAttendance sendLiveLocationRequest;
  CallForAttendance callForAttendance;
  CallForAttendance otherOptions;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        employeeId: json["employee_id"],
        email: json["email"],
        employeeName: json["employee_name"],
        department: json["department"],
        totalHrs: json["total_hrs"],
        viewAttendance: CallForAttendance.fromJson(json["view_attendance"]),
        editEmployee: CallForAttendance.fromJson(json["edit_employee"]),
        deleteEmployee: CallForAttendance.fromJson(json["delete_employee"]),
        viewLiveLocationEmployee:
            CallForAttendance.fromJson(json["view_live_location_employee"]),
        sendLiveLocationRequest:
            CallForAttendance.fromJson(json["send_live_location_request"]),
        callForAttendance:
            CallForAttendance.fromJson(json["call_for_attendance"]),
        otherOptions: CallForAttendance.fromJson(json["other_options"]),
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "email": email,
        "employee_name": employeeName,
        "department": department,
        "total_hrs": totalHrs,
        "view_attendance": viewAttendance.toJson(),
        "edit_employee": editEmployee.toJson(),
        "delete_employee": deleteEmployee.toJson(),
        "view_live_location_employee": viewLiveLocationEmployee.toJson(),
        "send_live_location_request": sendLiveLocationRequest.toJson(),
        "call_for_attendance": callForAttendance.toJson(),
        "other_options": otherOptions.toJson(),
      };
}

class CallForAttendance {
  CallForAttendance({
    required this.text,
    required this.link,
  });

  String text;
  String link;

  factory CallForAttendance.fromRawJson(String str) =>
      CallForAttendance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CallForAttendance.fromJson(Map<String, dynamic> json) =>
      CallForAttendance(
        text: json["text"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "link": link,
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
  int pageNumber;
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
