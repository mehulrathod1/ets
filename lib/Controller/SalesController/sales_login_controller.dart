// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/SalesModel/sales_login_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesLoginController {
  SalesLoginModel? salesLoginModel;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future salesLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var response = await postData(
      paramUri: ApiConstant.salesLogin,
      params: {'username': userName.text, 'password': password.text},
    );

    debugPrint("salesLogin response :- ${response.toString()}");

    if (response["status"] == 'True') {
      var res = SalesLoginModel.fromJson(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res.data.token);
      prefs.setString('userIdentity', 'sales');
      ApiConstant.userToken = res.data.token;
      salesLoginModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SalesDashboard()));
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
