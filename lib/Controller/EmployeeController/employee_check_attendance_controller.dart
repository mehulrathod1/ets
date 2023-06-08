import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_check_attendance_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeCheckAttendanceStatus {
  EmployeeCheckAttendanceModel? checkAttendanceModel;

  Future checkAttendanceStatus(BuildContext context, String currentDate) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeCheckAttendanceStatus,
        params: {
          'current_date': currentDate,
        });
    debugPrint(" response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeCheckAttendanceModel.fromJson(response);
      checkAttendanceModel = res;
      Navigator.pop(context);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(res.message),
      //     duration: const Duration(seconds: 2),
      //   ),
      // );

      ApiConstant.attendanceStatus = res.data.attendanceStatus.toString();
      print(ApiConstant.attendanceStatus);
    } else {
      Navigator.pop(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(response["message"]),
      //     duration: const Duration(seconds: 2),
      //   ),
      // );
    }
  }
}
