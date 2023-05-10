// To parse this JSON data, do
//
//     final holdAccessEmployee = holdAccessEmployeeFromJson(jsonString);

import 'dart:convert';

class HoldAccessEmployee {
  String status;
  String message;
  bool data;

  HoldAccessEmployee({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HoldAccessEmployee.fromRawJson(String str) => HoldAccessEmployee.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HoldAccessEmployee.fromJson(Map<String, dynamic> json) => HoldAccessEmployee(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
