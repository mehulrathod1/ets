import 'package:etsemployee/Models/EmployeeModel/employee_get_hour_request_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeGetHourRequestController {
  Future<EmployeeGetHourRequestModel> getEmployeeRequest(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetHourRequest);
    debugPrint(response);
    return EmployeeGetHourRequestModel.fromJson(response);
  }
}
