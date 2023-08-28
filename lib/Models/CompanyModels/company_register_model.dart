import 'dart:convert';

class CompanyRegisterModel {
  String status;
  String message;
  Data data;

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
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
