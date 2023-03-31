// To parse this JSON data, do
//
//     final companyViewImageModel = companyViewImageModelFromJson(jsonString);

import 'dart:convert';

class CompanyViewImageModel {
  CompanyViewImageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyViewImageModel.fromRawJson(String str) =>
      CompanyViewImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyViewImageModel.fromJson(Map<String, dynamic> json) =>
      CompanyViewImageModel(
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
  Data({
    required this.imageList,
  });

  List<ImageList> imageList;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imageList: List<ImageList>.from(
            json["image_list"].map((x) => ImageList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "image_list": List<dynamic>.from(imageList.map((x) => x.toJson())),
      };
}

class ImageList {
  ImageList({
    required this.statusIn,
    required this.inTime,
    required this.inImage,
    required this.statusOut,
    required this.outTime,
    required this.outImage,
  });

  String statusIn;
  String inTime;
  String inImage;
  String statusOut;
  String outTime;
  String outImage;

  factory ImageList.fromRawJson(String str) =>
      ImageList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
        statusIn: json["status_in"],
        inTime: json["in_time"],
        inImage: json["in_image"],
        statusOut: json["status_out"],
        outTime: json["out_time"],
        outImage: json["out_image"],
      );

  Map<String, dynamic> toJson() => {
        "status_in": statusIn,
        "in_time": inTime,
        "in_image": inImage,
        "status_out": statusOut,
        "out_time": outTime,
        "out_image": outImage,
      };
}
