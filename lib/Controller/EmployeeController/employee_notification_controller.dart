import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_notification_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeNotificationController {
  Future<EmployeeNotificationModel> getNotification(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeNotification);
    return EmployeeNotificationModel.fromJson(response);
  }
}
