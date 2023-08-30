import 'dart:convert';

class CompanyRegisterModel {
  String status;
  String message;
  dynamic data;

  CompanyRegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyRegisterModel.fromRawJson(String str) =>
      CompanyRegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyRegisterModel.fromJson(Map<String, dynamic> json) =>
      CompanyRegisterModel(
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
