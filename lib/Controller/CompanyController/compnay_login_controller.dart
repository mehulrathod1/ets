import 'package:etsemployee/Network/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../CompanyPortal/CompanyScreens/company_dashboard.dart';
import '../../Models/CompanyModels/company_login_model.dart';
import '../../Network/post_api_client.dart';

class CompanyLoginController {
  late CompanyLoginModel companyLoginModel;

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<CompanyLoginModel> companyLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    var response = await postData(
      paramUri: ApiConstant.companyLogin,
      params: {'username': userName.text, 'password': password.text},
    );

    var res = CompanyLoginModel.fromJson(response);

    if (res.status == 'True') {
      print('sucessful');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res.data.token);
      prefs.setString('userIdentity', 'company');

      ApiConstant.userToken = res.data.token;

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.message),
        duration: Duration(seconds: 2),
      ));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CompanyDashboard()));
    } else {
      print('no');
    }

    return res;
  }
}
