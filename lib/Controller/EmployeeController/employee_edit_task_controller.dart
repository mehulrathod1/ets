// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_edit_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:etsemployee/Screens/Contractors/ManageTask/manage_task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeEditTaskController {
  EmployeeEditTaskModel? employeeEditTaskModel;
  TextEditingController orderId = TextEditingController();
  TextEditingController taskStatus = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  Future getOrderForEmployeeTask(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetOrderForTaskList);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }

  Future editTask(BuildContext context, {required String id}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeEditTask + id, params: {
      'order_id': orderId.text,
      'taskstatus': taskStatus.text,
      'task_name': taskName.text,
      'due_date': dueDate.text,
      'task_description': taskDescription.text,
    });
    debugPrint("editTask response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeEditTaskModel.fromJson(response);
      employeeEditTaskModel = res;
      Navigator.pop(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ManageTask(profilePic: prefs.get("profilePic").toString())));
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
