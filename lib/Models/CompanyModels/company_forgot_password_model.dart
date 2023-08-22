import 'dart:convert';

class CompanyForgotPasswordModel {
  String status;
  String message;
  dynamic data;

  CompanyForgotPasswordModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyForgotPasswordModel.fromRawJson(String str) =>
      CompanyForgotPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      CompanyForgotPasswordModel(
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
