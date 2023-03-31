import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_contact_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeContactController {
  Future<EmployeeContactModel> getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeContactList);

    print(response);

    return EmployeeContactModel.fromJson(response);
  }
}
