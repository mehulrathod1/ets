import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_event_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeEventController {
  Future getEmployeeEvent(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeViewEvent);

    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeGetEventModel.fromJson(response);
    } else {
      return null;
    }
  }
}
