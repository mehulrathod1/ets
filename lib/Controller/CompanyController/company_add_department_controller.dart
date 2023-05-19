// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/CompanyModels/company_add_department_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class CompanyAddDepartmentController {
  CompanyAddDepartmentModel? addDepartmentModel;
  TextEditingController departmentName = TextEditingController();

  Future addDepartment(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.companyAddDepartment, params: {'department_name': departmentName.text});
    debugPrint("addDepartment response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddDepartmentModel.fromJson(response);
      addDepartmentModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
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
