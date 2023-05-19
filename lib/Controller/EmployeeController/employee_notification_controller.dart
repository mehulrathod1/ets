import 'package:etsemployee/Models/EmployeeModel/employee_notification_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeNotificationController {
  Future<EmployeeNotificationModel> getNotification(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeNotification);
    return EmployeeNotificationModel.fromJson(response);
  }
}
