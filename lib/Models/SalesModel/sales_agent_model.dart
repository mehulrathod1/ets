// To parse this JSON data, do
//
//     final salesAgentModel = salesAgentModelFromJson(jsonString);

import 'dart:convert';

class SalesAgentModel {
  SalesAgentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory SalesAgentModel.fromRawJson(String str) =>
      SalesAgentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesAgentModel.fromJson(Map<String, dynamic> json) =>
      SalesAgentModel(
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
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.profileImg,
    required this.isAgency,
    required this.forgotPassString,
    required this.isActive,
    required this.online,
    required this.agencyId,
    required this.joinDate,
    required this.totalNoCompany,
  });

  String id;
  String name;
  String email;
  Username? username;
  String phone;
  Address? address;
  City? city;
  MyState? state;
  String zip;
  ProfileImg? profileImg;
  String isAgency;
  String forgotPassString;
  String isActive;
  String online;
  String agencyId;
  DateTime joinDate;
  int totalNoCompany;

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: usernameValues.map[json["username"]],
        phone: json["phone"],
        address: addressValues.map[json["address"]],
        city: cityValues.map[json["city"]],
        state: stateValues.map[json["state"]],
        zip: json["zip"],
        profileImg: profileImgValues.map[json["profile_img"]],
        isAgency: json["is_agency"],
        forgotPassString: json["forgot_pass_string"],
        isActive: json["isActive"],
        online: json["online"],
        agencyId: json["agency_id"],
        joinDate: DateTime.parse(json["join_date"]),
        totalNoCompany: json["total_no_company"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": usernameValues.reverse[username],
        "phone": phone,
        "address": addressValues.reverse[address],
        "city": cityValues.reverse[city],
        "state": stateValues.reverse[state],
        "zip": zip,
        "profile_img": profileImgValues.reverse[profileImg],
        "is_agency": isAgency,
        "forgot_pass_string": forgotPassString,
        "isActive": isActive,
        "online": online,
        "agency_id": agencyId,
        "join_date": joinDate.toIso8601String(),
        "total_no_company": totalNoCompany,
      };
}

enum Address { ADDRESS, THE_800_FISKE_BLVD_N, PO_BOX_970123 }

final addressValues = EnumValues({
  "address": Address.ADDRESS,
  "PO BOX 970123": Address.PO_BOX_970123,
  "800 Fiske Blvd N": Address.THE_800_FISKE_BLVD_N
});

enum City { CITY, COCOA, BOCA_RATON }

final cityValues = EnumValues(
    {"Boca Raton": City.BOCA_RATON, "city": City.CITY, "Cocoa": City.COCOA});

enum ProfileImg { NOIMAGE1_PNG }

final profileImgValues = EnumValues({"noimage1.png": ProfileImg.NOIMAGE1_PNG});

enum MyState { STATE, FLORIDA, TEST }

final stateValues = EnumValues(
    {"Florida": MyState.FLORIDA, "state": MyState.STATE, "test": MyState.TEST});

enum Username { EMPTY, KATE_31323 }

final usernameValues =
    EnumValues({"": Username.EMPTY, "Kate_31323": Username.KATE_31323});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
