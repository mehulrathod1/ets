import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_delete_task_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeDeleteTaskController {
  Future<EmployeeDeleteTaskModel> deleteTask(
      BuildContext context, String id) async {
    var response = await getData(paramUri: ApiConstant.employeeDeleteTask + id);

    print(response);

    var res = EmployeeDeleteTaskModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
