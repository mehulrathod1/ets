import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/EmployeeModel/employee_login_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeLoginController {
  late EmployeeLoginModel companyLoginModel;

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<EmployeeLoginModel> employeeLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    var response = await postData(
      paramUri: ApiConstant.employeeLogin,
      params: {'username': userName.text, 'password': password.text},
    );

    var res = EmployeeLoginModel.fromJson(response);

    if (res.status == 'True') {
      print('sucessful');

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(response['msg']),
      //   duration: Duration(seconds: 1),
      // ));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res.data.token);
      prefs.setString('userIdentity', 'employee');

      ApiConstant.userToken = res.data.token;

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.message),
        duration: Duration(seconds: 2),
      ));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeDashboard()));
    } else {
      print('no');
    }

    return res;
  }
}
