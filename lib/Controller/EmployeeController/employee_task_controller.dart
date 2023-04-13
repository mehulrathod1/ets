import 'package:etsemployee/Models/EmployeeModel/employee_get_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeTaskController {
  Future getEmployeeTask(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeTaskList);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeTaskModel.fromJson(response);
    } else {
      return null;
    }
  }
}
