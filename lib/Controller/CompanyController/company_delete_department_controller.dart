// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/CompanyModels/company_delete_department_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class DeleteDepartmentController {
  CompanyDeleteDepartmentModel? deleteDepartmentModel;

  Future deleteDepartment(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(paramUri: ApiConstant.companyDeleteDepartment + id);
    debugPrint("deleteDepartment response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyDeleteDepartmentModel.fromJson(response);
      deleteDepartmentModel = res;
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
