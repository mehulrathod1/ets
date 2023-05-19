import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_department_model.dart';

class CompanyDepartmentController {
  Future getDepartment(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyDepartment);
    if (response["status"] == "True" && response["data"] != null) {
      return GetCompanyDepartmentModel.fromJson(response);
    } else {
      return null;
    }
  }
}
