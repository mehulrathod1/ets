// To parse this JSON data, do
//
//     final companyViewMapModel = companyViewMapModelFromJson(jsonString);

import 'dart:convert';

class CompanyViewMapModel {
  String status;
  String message;
  Data data;

  CompanyViewMapModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyViewMapModel.fromRawJson(String str) =>
      CompanyViewMapModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyViewMapModel.fromJson(Map<String, dynamic> json) =>
      CompanyViewMapModel(
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
  List<MapList> mapList;

  Data({
    required this.mapList,
  });

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
  String? statusIn;
  String? inTime;
  String? addressIn;
  String? statusOut;
  String? outTime;
  String? addressOut;
  String? timezoneName;
  String? inLat;
  String? inLong;
  String? outLat;
  String? outLong;

  MapList({
    required this.statusIn,
    required this.inTime,
    required this.addressIn,
    required this.statusOut,
    required this.outTime,
    required this.addressOut,
    required this.timezoneName,
    required this.inLat,
    required this.inLong,
    required this.outLat,
    required this.outLong,
  });

  factory MapList.fromRawJson(String str) => MapList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapList.fromJson(Map<String, dynamic> json) => MapList(
        statusIn: json["status_in"],
        inTime: json["in_time"],
        addressIn: json["address_in"],
        statusOut: json["status_out"],
        outTime: json["out_time"],
        addressOut: json["address_out"],
        timezoneName: json["timezone_name"],
        inLat: json["in_lat"],
        inLong: json["in_long"],
        outLat: json["out_lat"],
        outLong: json["out_long"],
      );

  Map<String, dynamic> toJson() => {
        "status_in": statusIn,
        "in_time": inTime,
        "address_in": addressIn,
        "status_out": statusOut,
        "out_time": outTime,
        "address_out": addressOut,
        "timezone_name": timezoneName,
        "in_lat": inLat,
        "in_long": inLong,
        "out_lat": outLat,
        "out_long": outLong,
      };
}
