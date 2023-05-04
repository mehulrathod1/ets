// ignore_for_file: constant_identifier_names

import 'dart:convert';

EmployeeContactModel employeeContactModelFromJson(String str) => EmployeeContactModel.fromJson(json.decode(str));

String employeeContactModelToJson(EmployeeContactModel data) => json.encode(data.toJson());

class EmployeeContactModel {
  EmployeeContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeContactModel.fromJson(Map<String, dynamic> json) => EmployeeContactModel(
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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.customerType,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.email,
    required this.homeOrOfficeNo,
    required this.mobileNo,
  });

  String id;
  String firstName;
  String lastName;
  String companyName;
  String customerType;
  String address;
  String city;
  String state;
  String zipcode;
  String email;
  String homeOrOfficeNo;
  String mobileNo;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyName: json["company_name"],
        customerType: json["customer_type"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        email: json["email"],
        homeOrOfficeNo: json["home_or_office_no"],
        mobileNo: json["mobile_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "company_name": companyName,
        "customer_type": customerType,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "email": email,
        "home_or_office_no": homeOrOfficeNo,
        "mobile_no": mobileNo,
      };
}

// enum City { TEST_CITY, TEST, COCOA }
//
// final cityValues = EnumValues({"Cocoa": City.COCOA, "test": City.TEST, "test city": City.TEST_CITY});
//
// enum MyState { STATE_TAST, TEST, FLORIDA }
//
// final stateValues = EnumValues({"Florida": MyState.FLORIDA, "state tast": MyState.STATE_TAST, "test": MyState.TEST});

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
