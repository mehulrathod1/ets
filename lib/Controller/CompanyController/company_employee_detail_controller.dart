import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_employee_detail_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEmployeeDetailController {
  Future employeeDetail(BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyEmployeeDetail + id);
    debugPrint("deleteOrder response :- ${response.toString()}");
    return CompanyEmployeeDetailModel.fromJson(response);
  }

  Future getDepartmentList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyDepartment);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"];
    } else {
      return null;
    }
  }
}
