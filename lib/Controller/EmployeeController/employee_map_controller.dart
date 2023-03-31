import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_map_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeMapController {
  Future<EmployeeViewMapModel> getAttendanceHistory(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetMap);

    print(response);

    return EmployeeViewMapModel.fromJson(response);
  }
}
