// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/CompanyPortal/CompanyScreens/company_dashboard.dart';
import 'package:etsemployee/Models/CompanyModels/company_login_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyLoginController {
  CompanyLoginModel? companyLoginModel;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future companyLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postData(
      paramUri: ApiConstant.companyLogin,
      params: {'username': userName.text, 'password': password.text},
    );
    debugPrint("companyLogin response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyLoginModel.fromJson(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res.data.token);
      prefs.setString('userIdentity', 'company');
      ApiConstant.userToken = res.data.token;
      companyLoginModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CompanyDashboard()));
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
