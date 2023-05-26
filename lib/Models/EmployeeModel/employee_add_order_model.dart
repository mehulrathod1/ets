import 'dart:convert';

class EmployeeAddOrderModel {
  EmployeeAddOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  dynamic data;

  factory EmployeeAddOrderModel.fromRawJson(String str) =>
      EmployeeAddOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddOrderModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAddOrderModel(
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
