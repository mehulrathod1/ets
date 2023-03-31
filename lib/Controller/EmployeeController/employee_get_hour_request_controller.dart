import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_get_hour_request_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeGetHourRequestController {
  Future<EmployeeGetHourRequestModel> getEmployeeRequest(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetHourRequest);

    print(response);

    return EmployeeGetHourRequestModel.fromJson(response);
  }
}
