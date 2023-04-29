import 'package:etsemployee/Models/EmployeeModel/employee_attendance_history_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeAttendanceHistoryController {
  Future getAttendanceHistory({required BuildContext context, required String startDate, required String endDate, required int page}) async {
    var response = await getData(paramUri: "${ApiConstant.employeeAttendanceHistory}startdate=$startDate&enddate=$endDate&page=$page");
    if (response["status"] == "True") {
      return EmployeeAttendanceHistoryModel.fromJson(response);
    } else {
      return null;
    }
  }
}
