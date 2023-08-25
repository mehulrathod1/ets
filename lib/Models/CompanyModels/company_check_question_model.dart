import 'dart:convert';

class CompanyCheckQuestionModel {
  String status;
  String message;
  dynamic data;

  CompanyCheckQuestionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyCheckQuestionModel.fromRawJson(String str) =>
      CompanyCheckQuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyCheckQuestionModel.fromJson(Map<String, dynamic> json) =>
      CompanyCheckQuestionModel(
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
