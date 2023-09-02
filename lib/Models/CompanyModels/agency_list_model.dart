class AgencyListModel {
  String? status;
  String? message;
  Data? data;

  AgencyListModel({this.status, this.message, this.data});

  AgencyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<AgencyData>? agencyData;

  Data({this.agencyData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['AgencyData'] != null) {
      agencyData = <AgencyData>[];
      json['AgencyData'].forEach((v) {
        agencyData!.add(new AgencyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agencyData != null) {
      data['AgencyData'] = this.agencyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgencyData {
  String? id;
  String? name;

  AgencyData({this.id, this.name});

  AgencyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
