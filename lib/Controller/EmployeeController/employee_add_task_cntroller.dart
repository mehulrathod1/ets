import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_add_task_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeAddTaskController {
  TextEditingController orderId = TextEditingController();
  TextEditingController taskStatus = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  Future<EmployeeAddTaskModel> addTask(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeAddTask,
        params: {
          'order_id': orderId.text,
          'taskstatus': taskStatus.text,
          'task_name': taskName.text,
          'due_date': dueDate.text,
          'task_description': taskDescription.text,
        });

    var res = EmployeeAddTaskModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: Duration(seconds: 2),
    ));

    print(res.message);
    return res;
  }
}
