import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_forgot_password_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyForgotPasswordController {
  CompanyForgotPasswordModel? companyForgotPasswordModel;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();

  Future companyForgotPassword(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postData(
      paramUri: ApiConstant.companyForgotPassword,
      params: {'email': email.text, 'username': userName.text},
    );
    debugPrint("companypwd response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyForgotPasswordModel.fromJson(response);

      companyForgotPasswordModel = res;
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
