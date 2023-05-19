import 'dart:convert';

class EmployeeEstimateModel {
  EmployeeEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeEstimateModel.fromRawJson(String str) => EmployeeEstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeEstimateModel.fromJson(Map<String, dynamic> json) =>
      EmployeeEstimateModel(
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
    required this.companyId,
    required this.contactId,
    required this.estimateId,
    required this.estimateName,
    required this.estimateDescription,
    required this.dueDate,
    required this.employeeList,
    required this.amount,
    required this.createdBy,
    required this.empId,
    required this.markup,
    required this.tax,
  });

  String companyId;
  String contactId;
  String estimateId;
  String estimateName;
  String estimateDescription;
  DateTime dueDate;
  String employeeList;
  String amount;
  String createdBy;
  String empId;
  String markup;
  String tax;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        companyId: json["company_id"],
        contactId: json["contact_id"],
        estimateId: json["estimate_id"],
        estimateName: json["estimate_name"],
        estimateDescription: json["estimate_description"],
        dueDate: DateTime.parse(json["due_date"]),
        employeeList: json["employee_list"],
        amount: json["amount"],
        createdBy: json["created_by "],
        empId: json["emp_id"],
        markup: json["markup"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "contact_id": contactId,
        "estimate_id": estimateId,
        "estimate_name": estimateName,
        "estimate_description": estimateDescription,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "employee_list": employeeList,
        "amount": amount,
        "created_by ": createdBy,
        "emp_id": empId,
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
