import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_total_department_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyTotalDepartmentController {
  Future<CompanyTotalDepartmentModel> getTotalDepartment(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyTotalDepartment);
    return CompanyTotalDepartmentModel.fromJson(response);
  }
}
