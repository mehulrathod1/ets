// To parse this JSON data, do
//
//     final employeeGetInvoiceContactModel = employeeGetInvoiceContactModelFromJson(jsonString);

import 'dart:convert';

class CompanyGetInvoiceContactModel {
  String status;
  String message;
  Data data;

  CompanyGetInvoiceContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyGetInvoiceContactModel.fromRawJson(String str) =>
      CompanyGetInvoiceContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyGetInvoiceContactModel.fromJson(Map<String, dynamic> json) =>
      CompanyGetInvoiceContactModel(
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

  Data({
    required this.list,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["List"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  String contactInvoiceId;
  String contactId;
  String contactFirstName;
  String contactLastName;
  String employeeId;
  String description;
  String amount;
  String invoiceDate;
  String signatureName;
  String signature;

  ListElement({
    required this.contactInvoiceId,
    required this.contactId,
    required this.contactFirstName,
    required this.contactLastName,
    required this.employeeId,
    required this.description,
    required this.amount,
    required this.invoiceDate,
    required this.signatureName,
    required this.signature,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        contactInvoiceId: json["contact_invoice_id"],
        contactId: json["contact_id"],
        contactFirstName: json["contact_first_name"],
        contactLastName: json["contact_last_name"],
        employeeId: json["employee_id"],
        description: json["description"],
        amount: json["amount"],
        invoiceDate: json["invoice_date"],
        signatureName: json["signature_name"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "contact_invoice_id": contactInvoiceId,
        "contact_id": contactId,
        "contact_first_name": contactFirstName,
        "contact_last_name": contactLastName,
        "employee_id": employeeId,
        "description": description,
        "amount": amount,
        "invoice_date": invoiceDate,
        "signature_name": signatureName,
        "signature": signature,
      };
}
