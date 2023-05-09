// To parse this JSON data, do
//
//     final companyCustomerTypeModel = companyCustomerTypeModelFromJson(jsonString);

import 'dart:convert';

class CompanyCustomerTypeModel {
  String status;
  String message;
  Data data;

  CompanyCustomerTypeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyCustomerTypeModel.fromRawJson(String str) =>
      CompanyCustomerTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyCustomerTypeModel.fromJson(Map<String, dynamic> json) =>
      CompanyCustomerTypeModel(
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
  int key;
  String type;

  ListElement({
    required this.key,
    required this.type,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        key: json["key"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "Type": type,
      };
}
