// To parse this JSON data, do
//
//     final companyNoteModel = companyNoteModelFromJson(jsonString);

import 'dart:convert';

class CompanyNoteModel {
  CompanyNoteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyNoteModel.fromRawJson(String str) =>
      CompanyNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyNoteModel.fromJson(Map<String, dynamic> json) =>
      CompanyNoteModel(
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
  ListElement({
    required this.id,
    required this.noteName,
    required this.noteDescription,
    required this.noteStatus,
  });

  String id;
  String noteName;
  String noteDescription;
  String noteStatus;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        noteName: json["note_name"],
        noteDescription: json["note_description"],
        noteStatus: json["note_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "note_name": noteName,
        "note_description": noteDescription,
        "note_status": noteStatus,
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
  int pageNumber;
  int totalRows;
  int totalPages;

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
