import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_detele_estimate_model.dart';
import '../../Network/post_api_client.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_delete_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';

class DeleteEstimateController {
  EmployeeDeleteEstimate? deleteEstimate;
  Future employeeDeleteEstimate(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeDeleteEstimate + id);
    debugPrint("deleteTask response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeDeleteEstimate.fromJson(response);
      deleteEstimate = res;
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
