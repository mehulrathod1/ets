import 'dart:convert';

class EmployeeEditOrderModel {
  EmployeeEditOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory EmployeeEditOrderModel.fromRawJson(String str) => EmployeeEditOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeEditOrderModel.fromJson(Map<String, dynamic> json) => EmployeeEditOrderModel(
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
