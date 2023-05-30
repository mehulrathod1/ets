// To parse this JSON data, do
//
//     final companyAttendanceModel = companyAttendanceModelFromJson(jsonString);

import 'dart:convert';

CompanyAttendanceModel companyAttendanceModelFromJson(String str) =>
    CompanyAttendanceModel.fromJson(json.decode(str));

String companyAttendanceModelToJson(CompanyAttendanceModel data) =>
    json.encode(data.toJson());

class CompanyAttendanceModel {
  String status;
  String message;
  Data data;

  CompanyAttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAttendanceModel.fromJson(Map<String, dynamic> json) =>
      CompanyAttendanceModel(
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
  PaginationInfo paginationInfo;

  Data({
    required this.list,
    required this.paginationInfo,
  });

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
  String id;
  String name;
  String employeeId;
  String companyName;
  String? listIn;
  String? out;
  DateTime date;
  String workHours;
  String breakHours;
  String? location;
  Hours hours;
  Hours image;
  Hours map;

  ListElement({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.companyName,
    required this.listIn,
    required this.out,
    required this.date,
    required this.workHours,
    required this.breakHours,
    required this.location,
    required this.hours,
    required this.image,
    required this.map,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        employeeId: json["employee_id"],
        companyName: json["company_name"],
        listIn: json["in"],
        out: json["out"],
        date: DateTime.parse(json["date"]),
        workHours: json["work_hours"],
        breakHours: json["break_hours"],
        location: json["location"],
        hours: Hours.fromJson(json["Hours"]),
        image: Hours.fromJson(json["Image"]),
        map: Hours.fromJson(json["Map"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "employee_id": employeeId,
        "company_name": companyName,
        "in": listIn,
        "out": out,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "work_hours": workHours,
        "break_hours": breakHours,
        "location": location,
        "Hours": hours.toJson(),
        "Image": image.toJson(),
        "Map": map.toJson(),
      };
}

class Hours {
  Textt text;
  String link;

  Hours({
    required this.text,
    required this.link,
  });

  factory Hours.fromJson(Map<String, dynamic> json) => Hours(
        text: textValues.map[json["text"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "text": textValues.reverse[text],
        "link": link,
      };
}

enum Textt { VIEW_HOURS, VIEW_IMAGE, VIEW_MAP }

final textValues = EnumValues({
  "view hours": Textt.VIEW_HOURS,
  "view image": Textt.VIEW_IMAGE,
  "view map": Textt.VIEW_MAP
});

class PaginationInfo {
  int itemPerPage;
  int pageNumber;
  int totalRows;
  int totalPages;

  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    required this.totalPages,
  });

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
