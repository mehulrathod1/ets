// To parse this JSON data, do
//
//     final employeeViewMapModel = employeeViewMapModelFromJson(jsonString);

import 'dart:convert';

class EmployeeViewMapModel {
  EmployeeViewMapModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeViewMapModel.fromRawJson(String str) =>
      EmployeeViewMapModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeViewMapModel.fromJson(Map<String, dynamic> json) =>
      EmployeeViewMapModel(
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
    required this.mapList,
  });

  List<MapList> mapList;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mapList: List<MapList>.from(
            json["map_list"].map((x) => MapList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "map_list": List<dynamic>.from(mapList.map((x) => x.toJson())),
      };
}

class MapList {
  MapList({
    required this.statusIn,
    required this.inTime,
    required this.addressIn,
    required this.statusOut,
    required this.outTime,
    required this.addressOut,
  });

  String statusIn;
  String inTime;
  String addressIn;
  String statusOut;
  String outTime;
  String addressOut;

  factory MapList.fromRawJson(String str) => MapList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapList.fromJson(Map<String, dynamic> json) => MapList(
        statusIn: json["status_in"],
        inTime: json["in_time"],
        addressIn: json["address_in"],
        statusOut: json["status_out"],
        outTime: json["out_time"],
        addressOut: json["address_out"],
      );

  Map<String, dynamic> toJson() => {
        "status_in": statusIn,
        "in_time": inTime,
        "address_in": addressIn,
        "status_out": statusOut,
        "out_time": outTime,
        "address_out": addressOut,
      };
}
