import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/SalesModel/sales_login_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';
import '../../SalesPortal/SalesScreen/sales_dashboard.dart';

class SalesLoginController {
  late SalesLoginModel salesLoginModel;

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<SalesLoginModel> salesLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    var response = await postData(
      paramUri: ApiConstant.salesLogin,
      params: {'username': userName.text, 'password': password.text},
    );

    var res = SalesLoginModel.fromJson(response);

    if (res.status == 'True') {
      print('sucessful');

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(response['msg']),
      //   duration: Duration(seconds: 1),
      // ));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res.data.token);
      prefs.setString('userIdentity', 'sales');

      ApiConstant.userToken = res.data.token;

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.message),
        duration: Duration(seconds: 2),
      ));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SalesDashboard()));
    } else {
      print('no');
    }

    return res;
  }
}
