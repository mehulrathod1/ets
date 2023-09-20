import 'package:flutter/material.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyQuestionController {
  TextEditingController questionId = TextEditingController();
  TextEditingController answer = TextEditingController();

  Future getAllCompanySecurityQuestion(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.companyAllSecurityQuestion);
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }

  Future updateCompanyQuestion(
    BuildContext context,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyUpdateQuestion,
        params: {
          'qtn_id': questionId.text,
          'answer': answer.text,
        });
    if (response["status"] == 'True') {
      print("888888888888888888888888888888${response["message"]}");
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

  Future updateEmployeeQuestion(
    BuildContext context,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeUpdateQuestion,
        params: {
          'qtn_id': questionId.text,
          'answer': answer.text,
        });
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

  Future getAllEmployeeSecurityQuestion(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.employeeAllSecurityQuestion);
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
