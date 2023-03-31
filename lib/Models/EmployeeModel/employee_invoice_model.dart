// To parse this JSON data, do
//
//     final employeeInvoiceModel = employeeInvoiceModelFromJson(jsonString);

import 'dart:convert';

class EmployeeInvoiceModel {
  EmployeeInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeInvoiceModel.fromRawJson(String str) =>
      EmployeeInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeInvoiceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeInvoiceModel(
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
    required this.invoiceId,
    required this.companyId,
    required this.employeeId,
    required this.estimateId,
    required this.invoiceFor,
    required this.invoiceDescription,
    required this.amount,
    required this.invoiceDate,
    required this.tax,
    required this.costPlus,
    this.signature,
    required this.isPaid,
  });

  String invoiceId;
  String companyId;
  String? employeeId;
  String estimateId;
  String invoiceFor;
  String invoiceDescription;
  String amount;
  DateTime invoiceDate;
  String? tax;
  String? costPlus;
  dynamic signature;
  String isPaid;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        invoiceId: json["invoice_id"],
        companyId: json["company_id"],
        employeeId: json["employee_id"],
        estimateId: json["estimate_id"],
        invoiceFor: json["invoice_for"],
        invoiceDescription: json["invoice_description"],
        amount: json["amount"],
        invoiceDate: DateTime.parse(json["invoice_date"]),
        tax: json["tax"],
        costPlus: json["cost_plus"],
        signature: json["signature"],
        isPaid: json["isPaid"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId,
        "company_id": companyId,
        "employee_id": employeeId,
        "estimate_id": estimateId,
        "invoice_for": invoiceFor,
        "invoice_description": invoiceDescription,
        "amount": 'amount',
        "invoice_date":
            "${invoiceDate.year.toString().padLeft(4, '0')}-${invoiceDate.month.toString().padLeft(2, '0')}-${invoiceDate.day.toString().padLeft(2, '0')}",
        "tax": tax,
        "cost_plus": costPlus,
        "signature": signature,
        "isPaid": isPaid,
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
