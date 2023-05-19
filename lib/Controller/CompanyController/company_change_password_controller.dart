import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyChangePasswordController {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future companyChangePassword(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyChangePassword,
        params: {
          'opassword': oldPassword.text,
          'password': newPassword.text,
        });
    debugPrint("edit password response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
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
