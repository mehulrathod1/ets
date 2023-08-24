import 'dart:convert';

class CompanyGetQuestionModel {
  String status;
  String message;
  Data data;

  CompanyGetQuestionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyGetQuestionModel.fromRawJson(String str) =>
      CompanyGetQuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyGetQuestionModel.fromJson(Map<String, dynamic> json) =>
      CompanyGetQuestionModel(
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
  String qtnName;
  String answer;

  Data({
    required this.qtnId,
    required this.qtnName,
    required this.answer,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qtnId: json["qtn_id"],
        qtnName: json["qtn_name"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "qtn_id": qtnId,
        "qtn_name": qtnName,
        "answer": answer,
      };
}
