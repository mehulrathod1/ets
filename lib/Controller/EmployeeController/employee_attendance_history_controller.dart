import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_attendance_history_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeAttendanceHistoryController{

  Future<EmployeeAttendanceHistoryModel> getAttendanceHistory(
      BuildContext context) async {
    var response = await getData(
        paramUri: ApiConstant.employeeAttendanceHistory);

    print(response);

    return EmployeeAttendanceHistoryModel.fromJson(response);
  }
}