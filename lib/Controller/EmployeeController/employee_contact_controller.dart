// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_contact_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeContactController {
  Future getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeContactList);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeContactModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<bool> employeeDeleteContact({BuildContext? context, String? id}) async {
    showDialog(
        context: context!,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(paramUri: ApiConstant.employeeDeleteContact + id!);
    if (response["status"] == "True" && response["data"] != null) {
      Navigator.pop(context);
      return true;
    } else {
      Navigator.pop(context);
      return false;
    }
  }
}
