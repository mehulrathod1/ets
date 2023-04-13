import 'package:etsemployee/Models/EmployeeModel/employee_contact_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeContactController {
  Future getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeContactList);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeContactModel.fromJson(response);
    } else {
      return null;
    }
  }
}
