import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_total_emp_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyTotalEmployeeController {
  Future getTotalEmployee(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyTotalEmployee);
    if (response["status"] == "True" && response["data"] != null) {
      return TotalEmployeeModel.fromJson(response);
    } else {
      return null;
    }
  }
}
