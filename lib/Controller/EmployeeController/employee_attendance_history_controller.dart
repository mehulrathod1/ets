import 'package:etsemployee/Models/EmployeeModel/employee_attendance_history_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeAttendanceHistoryController {
  Future<EmployeeAttendanceHistoryModel> getAttendanceHistory(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeAttendanceHistory);
    debugPrint(response);
    return EmployeeAttendanceHistoryModel.fromJson(response);
  }
}