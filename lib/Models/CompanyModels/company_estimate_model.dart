// To parse this JSON data, do
//
//     final companyEstimateModel = companyEstimateModelFromJson(jsonString);

import 'dart:convert';

class CompanyEstimateModel {
  CompanyEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyEstimateModel.fromRawJson(String str) =>
      CompanyEstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyEstimateModel.fromJson(Map<String, dynamic> json) =>
      CompanyEstimateModel(
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
    required this.estimateId,
    required this.contactId,
    required this.employeeList,
    required this.estimateName,
    required this.estimateDescription,
    required this.dueDate,
    required this.amount,
    required this.markup,
    required this.tax,
  });

  String id;
  String estimateId;
  String contactId;
  String employeeList;
  String estimateName;
  String estimateDescription;
  DateTime dueDate;
  String amount;
  String markup;
  String tax;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        estimateId: json["estimate_id"],
        contactId: json["contact_id"],
        employeeList: json["employee_list"],
        estimateName: json["estimate_name"],
        estimateDescription: json["estimate_description"],
        dueDate: DateTime.parse(json["due_date"]),
        amount: json["amount"],
        markup: json["markup"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "estimate_id": estimateId,
        "contact_id": contactId,
        "employee_list": employeeList,
        "estimate_name": estimateName,
        "estimate_description": estimateDescription,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "markup": markup,
        "tax": tax,
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
