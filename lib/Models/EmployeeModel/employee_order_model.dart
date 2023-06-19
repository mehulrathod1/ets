// To parse this JSON data, do
//
//     final employeeOrderModel = employeeOrderModelFromJson(jsonString);

import 'dart:convert';

class EmployeeOrderModel {
  EmployeeOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeOrderModel.fromRawJson(String str) =>
      EmployeeOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeOrderModel.fromJson(Map<String, dynamic> json) =>
      EmployeeOrderModel(
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
    required this.companyId,
    required this.estimateId,
    required this.orderstatus,
    required this.orderName,
    required this.orderDescription,
    required this.amount,
    required this.startDate,
    required this.dueDate,
    required this.employeeId,
    required this.changeDescription,
    required this.signature,
    required this.signatureName,
  });

  String? id;
  String companyId;
  String estimateId;
  String orderstatus;
  String orderName;
  String orderDescription;
  String amount;
  DateTime startDate;
  DateTime dueDate;
  String? employeeId;
  String changeDescription;
  String signature;
  String signatureName;
  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        companyId: json["company_id"],
        estimateId: json["estimate_id"],
        orderstatus: json["orderstatus"],
        orderName: json["order_name"],
        orderDescription: json["order_description"],
        amount: json["amount"],
        startDate: DateTime.parse(json["start_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        employeeId: json["employee_id"],
        changeDescription: json["change_description"],
        signature: json["signature"],
        signatureName: json["signature_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "estimate_id": estimateId,
        "orderstatus": orderstatus,
        "order_name": orderName,
        "order_description": orderDescription,
        "amount": amount,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "employee_id": employeeId,
        "change_description": changeDescription,
        "signature": signature,
        "signature_name": signatureName,
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
