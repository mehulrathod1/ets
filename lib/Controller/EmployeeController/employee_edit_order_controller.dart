// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_edit_order_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:etsemployee/Screens/Contractors/ManageTask/manage_task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/Contractors/ManageOrder/manage_order.dart';

class EmployeeEditOrderController {
  EmployeeEditOrderModel? editOrderModel;
  TextEditingController estimateId = TextEditingController();
  TextEditingController orderStatus = TextEditingController();
  TextEditingController orderName = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController orderDescription = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  Future editOrder(BuildContext context,
      {required String? id, required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeEditOrder + id!,
        params: {
          'sig-dataUrl': signature!,
          'estimate_id': estimateId.text,
          'orderstatus': orderStatus.text,
          'order_name': orderName.text,
          'change_description': changeDescription.text,
          'order_description': orderDescription.text,
          'amount': amount.text,
          'start_date': startDate.text,
          'due_date': dueDate.text,
          'sign_name': '',
        });
    debugPrint("editOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeEditOrderModel.fromJson(response);
      editOrderModel = res;
      Navigator.pop(context);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ManageOrder(profilePic: prefs.get("profilePic").toString())));

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

  Future getEstimateOrderListForEmployee(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.employeeGetEstimateOrder);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
