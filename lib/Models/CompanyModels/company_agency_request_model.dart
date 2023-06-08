// To parse this JSON data, do
//
//     final companyAgencyRequestModel = companyAgencyRequestModelFromJson(jsonString);

import 'dart:convert';

class CompanyAgencyRequestModel {
  String status;
  String message;
  Data data;

  CompanyAgencyRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAgencyRequestModel.fromRawJson(String str) =>
      CompanyAgencyRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAgencyRequestModel.fromJson(Map<String, dynamic> json) =>
      CompanyAgencyRequestModel(
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
  List<ListElement> list;

  Data({
    required this.list,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["List"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  String agentid;
  String agentImg;
  String agentName;
  String createAt;
  String approved;
  String status;

  ListElement({
    required this.agentid,
    required this.agentImg,
    required this.agentName,
    required this.createAt,
    required this.approved,
    required this.status,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        agentid: json["agentid"],
        agentImg: json["agent_img"],
        agentName: json["agent_name"],
        createAt: json["create_at"],
        approved: json["approved"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "agentid": agentid,
        "agent_img": agentImg,
        "agent_name": agentName,
        "create_at": createAt,
        "approved": approved,
        "status": status,
      };
}
