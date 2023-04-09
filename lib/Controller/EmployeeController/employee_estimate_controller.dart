import 'package:etsemployee/Models/EmployeeModel/employee_estimate_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeEstimateController {
  Future<EmployeeEstimateModel> getEmployeeEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeEstimateList);
    return EmployeeEstimateModel.fromJson(response);
  }
}
