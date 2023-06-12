// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_send_hour_request_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

import '../../Screens/view_hour_request.dart';

class EmployeeSendHourRequestController {
  EmployeeSendHourRequestModel? employeeSendHourRequestModel;
  TextEditingController attendanceIn = TextEditingController();
  TextEditingController attendanceOut = TextEditingController();
  TextEditingController inTime = TextEditingController();
  TextEditingController outTime = TextEditingController();
  TextEditingController message = TextEditingController();

  Future addHourRequest(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeSendHourRequest,
        params: {
          'attendance_in': attendanceIn.text,
          'attendance_out': attendanceOut.text,
          'in_time': inTime.text,
          'out_time': outTime.text,
          'message': message.text,
        });
    debugPrint("addHourRequest response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeSendHourRequestModel.fromJson(response);
      employeeSendHourRequestModel = res;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
