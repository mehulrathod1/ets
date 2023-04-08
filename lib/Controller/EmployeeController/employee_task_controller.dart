import 'package:etsemployee/Models/EmployeeModel/employee_get_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeTaskController {
  Future<EmployeeTaskModel> getEmployeeTask(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeTaskList);
    debugPrint(response);
    return EmployeeTaskModel.fromJson(response);
  }
}
