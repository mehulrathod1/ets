// To parse this JSON data, do
//
//     final employeeAttendanceHistoryModel = employeeAttendanceHistoryModelFromJson(jsonString);

import 'dart:convert';

EmployeeAttendanceHistoryModel employeeAttendanceHistoryModelFromJson(String str) => EmployeeAttendanceHistoryModel.fromJson(json.decode(str));

String employeeAttendanceHistoryModelToJson(EmployeeAttendanceHistoryModel data) => json.encode(data.toJson());

class EmployeeAttendanceHistoryModel {
  EmployeeAttendanceHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeAttendanceHistoryModel.fromJson(Map<String, dynamic> json) => EmployeeAttendanceHistoryModel(
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
        list: List<ListElement>.from(json["List"].map((x) => ListElement.fromJson(x))),
        paginationInfo: PaginationInfo.fromJson(json["pagination_info"]),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "pagination_info": paginationInfo.toJson(),
      };
}

class ListElement {
  ListElement({
    required this.name,
    required this.date,
    required this.location,
    required this.hours,
    required this.image,
    required this.map,
  });

  String name;
  DateTime date;
  String location;
  Hours hours;
  Hours image;
  Hours map;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        location: json["location"],
        hours: Hours.fromJson(json["Hours"]),
        image: Hours.fromJson(json["Image"]),
        map: Hours.fromJson(json["Map"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "location": location,
        "Hours": hours.toJson(),
        "Image": image.toJson(),
        "Map": map.toJson(),
      };
}

class Hours {
  Hours({
    required this.text,
    required this.link,
  });

  MyText text;
  String link;

  factory Hours.fromJson(Map<String, dynamic> json) => Hours(
        text: textValues.map[json["text"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "text": textValues.reverse[text],
        "link": link,
      };
}

enum MyText { VIEW_HOURS, VIEW_IMAGE, VIEW_MAP }

final textValues = EnumValues({"view hours": MyText.VIEW_HOURS, "view image": MyText.VIEW_IMAGE, "view map": MyText.VIEW_MAP});

class PaginationInfo {
  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    required this.totalPages,
  });

  int itemPerPage;
  int pageNumber;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
