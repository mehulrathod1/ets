import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_forgot_password_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeForgotPasswordController {
  EmployeeForgotPasswordModel? employeeForgotPasswordModel;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();

  Future employeeForgotPassword(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postData(
      paramUri: ApiConstant.employeeForgotPassword,
      params: {'email': email.text, 'username': userName.text},
    );
    debugPrint("emp pwd response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeForgotPasswordModel.fromJson(response);

      employeeForgotPasswordModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
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
