// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_add_order_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeAddOrderController {
  TextEditingController sigDataUrl = TextEditingController();
  TextEditingController estimateId = TextEditingController();
  TextEditingController orderStatus = TextEditingController();
  TextEditingController orderName = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController orderDescription = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  Future<EmployeeAddOrderModel> addOrder(BuildContext context) async {
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeAddOrder, params: {
      'sig-dataUrl': sigDataUrl.text,
      'estimate_id': estimateId.text,
      'orderstatus': orderStatus.text,
      'order_name': orderName.text,
      'change_description': changeDescription.text,
      'order_description': orderDescription.text,
      'amount': amount.text,
      'start_date': startDate.text,
      'due_date': dueDate.text,
    });
    var res = EmployeeAddOrderModel.fromJson(response);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res.message),
        duration: const Duration(seconds: 2),
      ),
    );
    return res;
  }
}
