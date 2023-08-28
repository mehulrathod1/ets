// To parse this JSON data, do
//
//     final getCompanyOrderModel = getCompanyOrderModelFromJson(jsonString);

import 'dart:convert';

class GetCompanyOrderModel {
  GetCompanyOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory GetCompanyOrderModel.fromRawJson(String str) =>
      GetCompanyOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCompanyOrderModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyOrderModel(
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
    required this.orderstatus,
    required this.orderName,
    required this.orderDescription,
    required this.changeDescription,
    required this.amount,
    required this.signature,
    required this.startDate,
    required this.dueDate,
    required this.estimateAmount,
    required this.totalAmount,
    this.signatureName,
    required this.estimateId,
    required this.notifyEmployee,
  });

  String id;
  String orderstatus;
  String orderName;
  String orderDescription;
  String changeDescription;
  String amount;
  String signature;
  DateTime startDate;
  DateTime dueDate;
  dynamic estimateAmount;
  int totalAmount;
  String? signatureName;
  String estimateId;
  String notifyEmployee;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        orderstatus: json["orderstatus"],
        orderName: json["order_name"],
        orderDescription: json["order_description"],
        changeDescription: json["change_description"],
        amount: json["amount"],
        signature: json["signature"],
        startDate: DateTime.parse(json["start_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        estimateAmount: json["estimate_amount"],
        totalAmount: json["total_amount"],
        signatureName: json["signature_name"],
        estimateId: json["estimate_id"],
        notifyEmployee: json["notify_employee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderstatus": orderstatus,
        "order_name": orderName,
        "order_description": orderDescription,
        "change_description": changeDescription,
        "amount": amount,
        "signature": signature,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "estimate_amount": estimateAmount,
        "total_amount": totalAmount,
        "signature_name": signatureName,
        "estimate_id": estimateId,
        "notify_employee": notifyEmployee,
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
