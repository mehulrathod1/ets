import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_total_department_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyTotalDepartmentController {
  Future getTotalDepartment(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyTotalDepartment);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyTotalDepartmentModel.fromJson(response);
    } else {
      return null;
    }
  }
}
