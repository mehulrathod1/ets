// To parse this JSON data, do
//
//     final employeeNoteModel = employeeNoteModelFromJson(jsonString);

import 'dart:convert';

class EmployeeNoteModel {
  String status;
  String message;
  Data data;

  EmployeeNoteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeNoteModel.fromRawJson(String str) =>
      EmployeeNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeNoteModel.fromJson(Map<String, dynamic> json) =>
      EmployeeNoteModel(
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

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
  String estimateId;
  String noteName;
  String noteDescription;
  String noteStatus;

  ListElement({
    required this.id,
    required this.estimateId,
    required this.noteName,
    required this.noteDescription,
    required this.noteStatus,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        estimateId: json["estimate_id"],
        noteName: json["note_name"],
        noteDescription: json["note_description"],
        noteStatus: json["note_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "estimate_id": estimateId,
        "note_name": noteName,
        "note_description": noteDescription,
        "note_status": noteStatus,
      };
}

class PaginationInfo {
  int itemPerPage;
  String pageNumber;
  int totalRows;
  int totalPages;

  PaginationInfo({
    required this.itemPerPage,
    required this.pageNumber,
    required this.totalRows,
    required this.totalPages,
  });

  factory PaginationInfo.fromRawJson(String str) =>
      PaginationInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
