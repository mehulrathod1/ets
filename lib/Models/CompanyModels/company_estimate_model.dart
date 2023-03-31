// To parse this JSON data, do
//
//     final companyEstimateModel = companyEstimateModelFromJson(jsonString);

import 'dart:convert';

CompanyEstimateModel companyEstimateModelFromJson(String str) =>
    CompanyEstimateModel.fromJson(json.decode(str));

String companyEstimateModelToJson(CompanyEstimateModel data) =>
    json.encode(data.toJson());

class CompanyEstimateModel {
  CompanyEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyEstimateModel.fromJson(Map<String, dynamic> json) =>
      CompanyEstimateModel(
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
    required this.totalHrs,
    required this.viewAttendance,
    required this.editEmployee,
    required this.deleteEmployee,
    required this.viewLiveLocationEmployee,
    required this.sendLiveLocationRequest,
    required this.callForAttendance,
    required this.otherOptions,
  });

  String employeeId;
  Email email;
  String employeeName;
  Department department;
  String? totalHrs;
  CallForAttendance viewAttendance;
  CallForAttendance editEmployee;
  CallForAttendance deleteEmployee;
  CallForAttendance viewLiveLocationEmployee;
  CallForAttendance sendLiveLocationRequest;
  CallForAttendance callForAttendance;
  CallForAttendance otherOptions;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        employeeId: json["employee_id"],
        email: emailValues.map[json["email"]]!,
        employeeName: json["employee_name"],
        department: departmentValues.map[json["department"]]!,
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
        "email": emailValues.reverse[email],
        "employee_name": employeeName,
        "department": departmentValues.reverse[department],
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

  MyText text;
  String link;

  factory CallForAttendance.fromJson(Map<String, dynamic> json) =>
      CallForAttendance(
        text: textValues.map[json["text"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "text": textValues.reverse[text],
        "link": link,
      };
}

enum MyText {
  CALL_FOR_ATTENDANCE_REQUEST,
  DELETE_EMPLOYEE,
  EDIT_EMPLOYEE,
  HOLD_ACCESS,
  SEND_LOCATION_REQUEST,
  VIEW_ATTENDANCE_FOR_THE_EMPLOYEE,
  VIEW_LOCATION
}

final textValues = EnumValues({
  "Call for attendance request": MyText.CALL_FOR_ATTENDANCE_REQUEST,
  "Delete Employee": MyText.DELETE_EMPLOYEE,
  "Edit Employee": MyText.EDIT_EMPLOYEE,
  "hold_access": MyText.HOLD_ACCESS,
  "Send Location Request": MyText.SEND_LOCATION_REQUEST,
  "view attendance for the employee": MyText.VIEW_ATTENDANCE_FOR_THE_EMPLOYEE,
  "View Location": MyText.VIEW_LOCATION
});

enum Department { IT, ACCOUNT, MANAGEMENT }

final departmentValues = EnumValues({
  "Account": Department.ACCOUNT,
  "IT": Department.IT,
  "Management": Department.MANAGEMENT
});

enum Email { CRAZYCODER09_GMAIL_COM, CRAZYCODER08_GMAIL_COM }

final emailValues = EnumValues({
  "crazycoder08@gmail.com": Email.CRAZYCODER08_GMAIL_COM,
  "crazycoder09@gmail.com": Email.CRAZYCODER09_GMAIL_COM
});

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
