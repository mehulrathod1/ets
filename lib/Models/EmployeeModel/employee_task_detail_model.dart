// To parse this JSON data, do
//
//     final employeeTaskDetailModel = employeeTaskDetailModelFromJson(jsonString);

import 'dart:convert';

class EmployeeTaskDetailModel {
  EmployeeTaskDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeTaskDetailModel.fromRawJson(String str) =>
      EmployeeTaskDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeTaskDetailModel.fromJson(Map<String, dynamic> json) =>
      EmployeeTaskDetailModel(
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
  });

  List<ListElement> list;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["List"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.companyId,
    required this.orderId,
    this.taskStatus,
    required this.taskName,
    required this.taskDescription,
    required this.dueDate,
  });

  String companyId;
  String orderId;
  dynamic taskStatus;
  String taskName;
  String taskDescription;
  DateTime dueDate;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        companyId: json["company_id"],
        orderId: json["order_id"],
        taskStatus: json["task_status"],
        taskName: json["task_name"],
        taskDescription: json["task_description"],
        dueDate: DateTime.parse(json["due_date"]),
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "order_id": orderId,
        "task_status": taskStatus,
        "task_name": taskName,
        "task_description": taskDescription,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
      };
}
