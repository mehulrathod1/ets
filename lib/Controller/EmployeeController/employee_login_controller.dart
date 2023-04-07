// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_login_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeLoginController {
  EmployeeLoginModel? employeeLoginModel;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future employeeLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var response = await postData(
      paramUri: ApiConstant.employeeLogin,
      params: {'username': userName.text, 'password': password.text},
    );

    debugPrint("employeeLogin response :- ${response.toString()}");

    if (response["status"] == 'True') {
      var res = EmployeeLoginModel.fromJson(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res.data.token);
      prefs.setString('userIdentity', 'employee');
      ApiConstant.userToken = res.data.token;
      employeeLoginModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
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
