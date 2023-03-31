// To parse this JSON data, do
//
//     final companyHourModel = companyHourModelFromJson(jsonString);

import 'dart:convert';

class CompanyHourModel {
  CompanyHourModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyHourModel.fromRawJson(String str) =>
      CompanyHourModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyHourModel.fromJson(Map<String, dynamic> json) =>
      CompanyHourModel(
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
    required this.hoursList,
  });

  List<HoursList> hoursList;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hoursList: List<HoursList>.from(
            json["hours_list"].map((x) => HoursList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hours_list": List<dynamic>.from(hoursList.map((x) => x.toJson())),
      };
}

class HoursList {
  HoursList({
    required this.hoursListIn,
    required this.out,
    required this.totalHours,
  });

  String hoursListIn;
  String out;
  String totalHours;

  factory HoursList.fromRawJson(String str) =>
      HoursList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HoursList.fromJson(Map<String, dynamic> json) => HoursList(
        hoursListIn: json["in"],
        out: json["out"],
        totalHours: json["total_hours"],
      );

  Map<String, dynamic> toJson() => {
        "in": hoursListIn,
        "out": out,
        "total_hours": totalHours,
      };
}
