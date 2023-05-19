import 'dart:convert';

class EmployeeAddTaskModel {
  EmployeeAddTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory EmployeeAddTaskModel.fromRawJson(String str) => EmployeeAddTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddTaskModel.fromJson(Map<String, dynamic> json) => EmployeeAddTaskModel(
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
