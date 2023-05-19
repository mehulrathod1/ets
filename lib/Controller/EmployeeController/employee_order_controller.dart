import 'package:etsemployee/Models/EmployeeModel/employee_order_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeOrderController {
  Future getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeOrderList);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeOrderModel.fromJson(response);
    } else {
      return null;
    }
  }
}
