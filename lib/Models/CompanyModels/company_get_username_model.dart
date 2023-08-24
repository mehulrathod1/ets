import 'dart:convert';

class CompanyGetUsernameModel {
  String status;
  String message;
  Data data;

  CompanyGetUsernameModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyGetUsernameModel.fromRawJson(String str) =>
      CompanyGetUsernameModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyGetUsernameModel.fromJson(Map<String, dynamic> json) =>
      CompanyGetUsernameModel(
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
  String username;

  ListElement({
    required this.username,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
