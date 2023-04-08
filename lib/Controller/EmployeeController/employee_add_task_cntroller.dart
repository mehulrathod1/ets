// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_add_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeAddTaskController {
  EmployeeAddTaskModel? addTaskModel;
  TextEditingController orderId = TextEditingController();
  TextEditingController taskStatus = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  Future addTask(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeAddTask, params: {
      'order_id': orderId.text,
      'taskstatus': taskStatus.text,
      'task_name': taskName.text,
      'due_date': dueDate.text,
      'task_description': taskDescription.text,
    });
    debugPrint("addTask response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeAddTaskModel.fromJson(response);
      addTaskModel = res;
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
