// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_delete_order_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeDeleteOrderController {
  EmployeeDeleteOrderModel? deleteOrderModel;

  Future deleteOrder(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(paramUri: ApiConstant.employeeDeleteOrder + id);
    debugPrint("deleteOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeDeleteOrderModel.fromJson(response);
      deleteOrderModel = res;
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
