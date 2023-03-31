import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_delete_department_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class DeleteDepartmentController{

  Future<CompanyDeleteDepartmentModel> deleteDepartment(
      BuildContext context, String id) async {
    var response =
    await getData(paramUri: ApiConstant.companyDeleteDepartment + id);

    print(response);

    var res = CompanyDeleteDepartmentModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}