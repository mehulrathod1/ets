import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_add_task_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddTaskController {
  CompanyAddTaskModel? addTaskModel;

  TextEditingController orderId = TextEditingController();
  TextEditingController taskStatus = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  Future addtask(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await postDataWithHeader(paramUri: ApiConstant.companyAddTask, params: {
      'order_id': orderId.text,
      'taskstatus': taskStatus.text,
      'task_name': taskName.text,
      'task_description': taskDescription.text,
      'employeelist': '',
      'due_date': dueDate.text,
    });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddTaskModel.fromJson(response);
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
