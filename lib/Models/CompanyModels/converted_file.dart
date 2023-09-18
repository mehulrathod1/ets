import 'dart:convert';

class CSVDowunloadModel {
  String status;
  String message;
  Data data;

  CSVDowunloadModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CSVDowunloadModel.fromRawJson(String str) =>
      CSVDowunloadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CSVDowunloadModel.fromJson(Map<String, dynamic> json) =>
      CSVDowunloadModel(
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
  String id;
  String downloadUrl;

  Data({
    required this.id,
    required this.downloadUrl,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "download_url": downloadUrl,
  };
}