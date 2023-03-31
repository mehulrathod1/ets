import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_send_hour_request_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeSendHourRequestController {
  TextEditingController attendanceIn = TextEditingController();
  TextEditingController attendanceOut = TextEditingController();
  TextEditingController inTime = TextEditingController();
  TextEditingController outTime = TextEditingController();
  TextEditingController message = TextEditingController();

  Future<EmployeeSendHourRequestModel> addHourRequest(
      BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeSendHourRequest,
        params: {
          'attendance_in': attendanceIn.text,
          'attendance_out': attendanceOut.text,
          'in_time': inTime.text,
          'out_time': outTime.text,
          'message': message.text,
        });

    var res = EmployeeSendHourRequestModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: Duration(seconds: 2),
    ));

    print(res.message);
    return res;
  }
}
