// To parse this JSON data, do
//
//     final companyApprovalModel = companyApprovalModelFromJson(jsonString);

import 'dart:convert';

class CompanyApprovalModel {
  CompanyApprovalModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyApprovalModel.fromRawJson(String str) =>
      CompanyApprovalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyApprovalModel.fromJson(Map<String, dynamic> json) =>
      CompanyApprovalModel(
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
    required this.id,
    required this.currentEmployeeImg,
    required this.employeeName,
    required this.reasonToChangeImg,
    required this.date,
  });

  String id;
  String currentEmployeeImg;
  String employeeName;
  String reasonToChangeImg;
  String date;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        currentEmployeeImg: json["current_employee_img"],
        employeeName: json["employee_name"],
        reasonToChangeImg: json["reason_to_change_img"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "current_employee_img": currentEmployeeImg,
        "employee_name": employeeName,
        "reason_to_change_img": reasonToChangeImg,
        "date": date,
      };
}
