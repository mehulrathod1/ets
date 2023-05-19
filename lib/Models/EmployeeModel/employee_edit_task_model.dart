import 'dart:convert';

class EmployeeEditTaskModel {
  EmployeeEditTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory EmployeeEditTaskModel.fromRawJson(String str) => EmployeeEditTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeEditTaskModel.fromJson(Map<String, dynamic> json) => EmployeeEditTaskModel(
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
