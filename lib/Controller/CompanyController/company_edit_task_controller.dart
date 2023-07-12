import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyContractors/MaangeCompanyTask/manage_task.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEditTaskController {
  TextEditingController orderId = TextEditingController();
  TextEditingController taskStatus = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController employeeList = TextEditingController();

  Future editTask(BuildContext context, String id,
      {required String? employeeId}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditTask + id,
        params: {
          'order_id': orderId.text,
          'taskstatus': taskStatus.text,
          'task_name': taskName.text,
          'task_description': taskDescription.text,
          'due_date': dueDate.text,
          'employeelist': employeeId!,
        });
    debugPrint(" response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ManageCompanyTask()));
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

  Future getEmployeeListForCompany(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyEmployeeList);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"];
    } else {
      return null;
    }
  }
}
