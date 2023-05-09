// To parse this JSON data, do
//
//     final companyNotificationModel = companyNotificationModelFromJson(jsonString);

import 'dart:convert';

class CompanyNotificationModel {
  CompanyNotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyNotificationModel.fromRawJson(String str) =>
      CompanyNotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyNotificationModel.fromJson(Map<String, dynamic> json) =>
      CompanyNotificationModel(
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
    required this.hasMoreData,
  });

  List<ListElement> list;
  String hasMoreData;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["List"].map((x) => ListElement.fromJson(x))),
        hasMoreData: json["has_more_data"],
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "has_more_data": hasMoreData,
      };
}

class ListElement {
  ListElement({
    required this.id,
    required this.employeeImg,
    required this.notificationMsg,
    required this.msg,
    required this.date,
    required this.button,
  });

  String id;
  String? employeeImg;
  String notificationMsg;
  String msg;
  DateTime date;
  Button button;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        employeeImg: json["employee_img"],
        notificationMsg: json["notification_msg"],
        msg: json["msg"],
        date: DateTime.parse(json["date"]),
        button: Button.fromJson(json["button"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_img": employeeImg,
        "notification_msg": notificationMsg,
        "msg": msg,
        "date": date.toIso8601String(),
        "button": button.toJson(),
      };
}

class Button {
  Button({
    required this.button,
    required this.location,
  });

  String button;
  String location;

  factory Button.fromRawJson(String str) => Button.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Button.fromJson(Map<String, dynamic> json) => Button(
        button: json["button"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "button": button,
        "location": location,
      };
}
