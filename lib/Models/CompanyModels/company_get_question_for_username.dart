import 'dart:convert';

class CompanyGetQuestionForUserNameModel {
  String status;
  String message;
  Data data;

  CompanyGetQuestionForUserNameModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyGetQuestionForUserNameModel.fromRawJson(String str) =>
      CompanyGetQuestionForUserNameModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyGetQuestionForUserNameModel.fromJson(
          Map<String, dynamic> json) =>
      CompanyGetQuestionForUserNameModel(
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
  String qtnId;
  String qtn;

  Data({
    required this.qtnId,
    required this.qtn,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qtnId: json["qtn_id"],
        qtn: json["qtn"],
      );

  Map<String, dynamic> toJson() => {
        "qtn_id": qtnId,
        "qtn": qtn,
      };
}
