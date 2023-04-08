import 'package:etsemployee/Models/EmployeeModel/employee_contact_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeContactController {
  Future<EmployeeContactModel> getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeContactList);
    debugPrint(response);
    return EmployeeContactModel.fromJson(response);
  }
}
