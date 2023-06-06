import 'package:etsemployee/Models/CompanyModels/GetCompanyEmployeeModel.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class GetCompanyEmployeeController {
  Future getCompanyEmployee(BuildContext context,
      {String? search, int? page}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.companyAllEmployee}searchName=$search&page=$page");
    if (response["status"] == "True" && response["data"] != null) {
      return GetCompanyEmployeeModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future getCompanyEmployeeList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyInbox);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
