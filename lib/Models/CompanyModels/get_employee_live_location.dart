// To parse this JSON data, do
//
//     final getEmployeeLiveLocation = getEmployeeLiveLocationFromJson(jsonString);

import 'dart:convert';

class GetEmployeeLiveLocation {
  String status;
  String message;
  Data data;

  GetEmployeeLiveLocation({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetEmployeeLiveLocation.fromRawJson(String str) =>
      GetEmployeeLiveLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetEmployeeLiveLocation.fromJson(Map<String, dynamic> json) =>
      GetEmployeeLiveLocation(
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
  String location;
  String lat;
  String long;
  Status status;
  DateTime date;

  Data({
    required this.location,
    required this.lat,
    required this.long,
    required this.status,
    required this.date,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        location: json["location"],
        lat: json["lat"],
        long: json["long"],
        status: Status.fromJson(json["status"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "lat": lat,
        "long": long,
        "status": status.toJson(),
        "date": date.toIso8601String(),
      };
}

class Status {
  String statusValue;
  String msg;

  Status({
    required this.statusValue,
    required this.msg,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusValue: json["status_value"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status_value": statusValue,
        "msg": msg,
      };
}
