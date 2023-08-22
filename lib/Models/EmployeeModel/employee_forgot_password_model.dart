import 'dart:convert';

class EmployeeForgotPasswordModel {
  String status;
  String message;
  dynamic data;

  EmployeeForgotPasswordModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeForgotPasswordModel.fromRawJson(String str) =>
      EmployeeForgotPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      EmployeeForgotPasswordModel(
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
