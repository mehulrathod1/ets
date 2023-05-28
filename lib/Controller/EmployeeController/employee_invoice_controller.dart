// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_invoice_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeInvoiceController {
  Future getEmployeeInvoice(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeViewInvoice, params: {});
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeInvoiceModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<bool> deleteEmployeeInvoice(
      {BuildContext? context, String? id}) async {
    showDialog(
        context: context!,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeDeleteInvoice + id!);
    if (response["status"] == "True" && response["data"] != null) {
      Navigator.pop(context);

      return true;
    } else {
      Navigator.pop(context);
      return false;
    }
  }
}
