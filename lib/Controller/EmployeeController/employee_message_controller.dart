import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_message_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeMessageController {
  Future getMessage(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeMessage);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeMessageModel.fromJson(response);
    } else {
      return null;
    }
  }
}
