import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_add_department_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddDepartmentController {
  TextEditingController departmentName = TextEditingController();

  Future<CompanyAddDepartmentModel> addDepartment(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddDepartment,
        params: {
          'department_name': departmentName.text,
        });
    var res = CompanyAddDepartmentModel.fromJson(response);
    print(res.message);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: Duration(seconds: 2),
    ));

    return res;
  }
}
