import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_estimate_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeEstimateController {
  Future<EmployeeEstimateModel> getEmployeeEstimate(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeEstimateList);

    print(response);
    return EmployeeEstimateModel.fromJson(response);
  }
}
