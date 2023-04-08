import 'dart:convert';

class CompanyCallRequestModel {
  CompanyCallRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory CompanyCallRequestModel.fromRawJson(String str) => CompanyCallRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyCallRequestModel.fromJson(Map<String, dynamic> json) => CompanyCallRequestModel(
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
