// To parse this JSON data, do
//
//     final employeeTaskModel = employeeTaskModelFromJson(jsonString);

import 'dart:convert';

class EmployeeTaskModel {
  EmployeeTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeTaskModel.fromRawJson(String str) => EmployeeTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeTaskModel.fromJson(Map<String, dynamic> json) => EmployeeTaskModel(
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
    required this.id,
    required this.companyId,
    required this.orderId,
    this.taskStatus,
    required this.taskName,
    required this.taskDescription,
    required this.dueDate,
  });

  String id;
  String companyId;
  String orderId;
  dynamic taskStatus;
  String taskName;
  String taskDescription;
  DateTime dueDate;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    companyId: json["company_id"],
    orderId: json["order_id"],
    taskStatus: json["task_status"],
    taskName: json["task_name"],
    taskDescription: json["task_description"],
    dueDate: DateTime.parse(json["due_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "order_id": orderId,
    "task_status": taskStatus,
    "task_name": taskName,
    "task_description": taskDescription,
    "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
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

  factory PaginationInfo.fromRawJson(String str) => PaginationInfo.fromJson(json.decode(str));

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
