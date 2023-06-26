import 'dart:convert';

class EmployeeAddContactModel {
  EmployeeAddContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  dynamic data;

  factory EmployeeAddContactModel.fromRawJson(String str) =>
      EmployeeAddContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddContactModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAddContactModel(
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

class Data {
  Data();

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
