import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_order_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeOrderController {
  Future<EmployeeOrderModel> getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeOrderList);

    print(response);
    return EmployeeOrderModel.fromJson(response);
  }
}
