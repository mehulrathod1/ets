import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEditTaskController {
  TextEditingController orderId = TextEditingController();
  TextEditingController orderStatus = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  Future editTask(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditTask + id,
        params: {
          'order_id': orderId.text,
          'taskstatus': orderStatus.text,
          'task_name': taskName.text,
          'task_description': taskDescription.text,
          'due_date': dueDate.text,
          'employeelist': '',
        });
    debugPrint(" response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
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
