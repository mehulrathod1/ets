import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_get_task_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeTaskController {
  Future<EmployeeTaskModel> getEmployeeTask(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeTaskList);

    print(response);

    return EmployeeTaskModel.fromJson(response);
  }
}
