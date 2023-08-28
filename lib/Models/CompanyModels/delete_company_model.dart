import 'dart:convert';

class DeleteCompanyModel {
  String status;
  String message;
  Data data;

  DeleteCompanyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteCompanyModel.fromRawJson(String str) =>
      DeleteCompanyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteCompanyModel.fromJson(Map<String, dynamic> json) =>
      DeleteCompanyModel(
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
