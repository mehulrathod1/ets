import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_get_question_for_username.dart';
import '../../Models/CompanyModels/company_get_username_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyResetUsernameController {
  CompanyGetUsernameModel? companyGetUsernameModel;
  CompanyGetQuestionForUserNameModel? companyGetQuestionForUserNameModel;

  TextEditingController email = TextEditingController();

  Future companyGetUserName(BuildContext context, String email) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postData(
      paramUri: ApiConstant.companyGetUsername,
      params: {'email': email},
    );

    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyGetUsernameModel.fromJson(response);
      companyGetUsernameModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyGetUsernameModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      // return null;
    }
  }

  Future companyGetUserNameList(BuildContext context, String email) async {
    var response = await postData(
      paramUri: ApiConstant.companyGetUsername,
      params: {'email': email},
    );
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }

  Future companyGetQuestionForUserName(
      BuildContext context, String email) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postData(
      paramUri: ApiConstant.companyGetQuestion,
      params: {'email': email},
    );

    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyGetQuestionForUserNameModel.fromJson(response);
      companyGetQuestionForUserNameModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyGetQuestionForUserNameModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      // return null;
    }
  }
}
