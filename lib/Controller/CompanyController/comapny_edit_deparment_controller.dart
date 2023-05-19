import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_edit_department_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEditDepartmentController {
  CompanyEditDepartmentModel? editDepartmentModel;
  TextEditingController departmentName = TextEditingController();
  Future editDepartment(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditDepartment + id,
        params: {
          'department_name': departmentName.text,
        });

    if (response["status"] == 'True') {
      var res = CompanyEditDepartmentModel.fromJson(response);
      editDepartmentModel = res;
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
