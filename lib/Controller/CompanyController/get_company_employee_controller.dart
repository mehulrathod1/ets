import 'package:etsemployee/Models/CompanyModels/GetCompanyEmployeeModel.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class GetCompanyEmployeeController {
  Future getCompanyEmployee(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyAllEmployee);
    if (response["status"] == "True" && response["data"] != null) {
      return GetCompanyEmployeeModel.fromJson(response);
    } else {
      return null;
    }
  }
}
