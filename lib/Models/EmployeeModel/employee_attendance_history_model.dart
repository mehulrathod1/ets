// ignore_for_file: constant_identifier_names

import 'dart:convert';

EmployeeAttendanceHistoryModel employeeAttendanceHistoryModelFromJson(
        String str) =>
    EmployeeAttendanceHistoryModel.fromJson(json.decode(str));

String employeeAttendanceHistoryModelToJson(
        EmployeeAttendanceHistoryModel data) =>
    json.encode(data.toJson());

class EmployeeAttendanceHistoryModel {
  EmployeeAttendanceHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeAttendanceHistoryModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendanceHistoryModel(
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
    required this.list,
    required this.paginationInfo,
  });

  List<ListElement> list;
  PaginationInfo paginationInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["List"].map((x) => ListElement.fromJson(x))),
        paginationInfo: PaginationInfo.fromJson(json["pagination_info"]),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "pagination_info": paginationInfo.toJson(),
      };
}

class ListElement {
  ListElement({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.timeImageMap,
  });

  String id;
  String name;
  DateTime date;
  String location;
  List<TimeImageMap> timeImageMap;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        location: json["location"] ?? "",
        timeImageMap: List<TimeImageMap>.from(
            json["time_image_map"].map((x) => TimeImageMap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "location": location,
        "time_image_map":
            List<dynamic>.from(timeImageMap.map((x) => x.toJson())),
      };
}

class TimeImageMap {
  TimeImageMap({
    required this.inn,
    required this.out,
    required this.totalHours,
    required this.inImage,
    required this.outImage,
    required this.addressIn,
    required this.addressOut,
  });

  String inn;
  String out;
  String totalHours;
  String inImage;
  String outImage;
  String addressIn;
  String addressOut;

  factory TimeImageMap.fromJson(Map<String, dynamic> json) => TimeImageMap(
        inn: json["in"],
        out: json["out"],
        totalHours: json["total_hours"],
        inImage: json["in_image"],
        outImage: json["out_image"],
        addressIn: json["address_in"],
        addressOut: json["address_out"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "in": inn,
        "out": out,
        "total_hours": totalHours,
        "in_image": inImage,
        "out_image": outImage,
        "address_in": addressIn,
        "address_out": addressOut,
      };
}

class PaginationInfo {
  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    required this.totalPages,
  });

  int itemPerPage;
  String pageNumber;
  int totalRows;
  int totalPages;

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
        itemPerPage: json["item_per_page"],
        pageNumber: json["page_number"],
        totalRows: json["total_rows"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "item_per_page": itemPerPage,
        "page_number": pageNumber,
        "total_rows": totalRows,
        "total_pages": totalPages,
      };
}
