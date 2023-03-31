import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_delete_employee_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyDeleteCompanyController {
  Future<CompanyDeleteEmployeeModel> deleteEmployee(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyDeleteEmployee + id);

    print(response);

    var res = CompanyDeleteEmployeeModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
