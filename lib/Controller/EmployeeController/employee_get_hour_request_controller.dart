import 'package:etsemployee/Models/EmployeeModel/employee_get_hour_request_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeGetHourRequestController {
  Future getEmployeeRequest(BuildContext context, {String? search, int? page}) async {
    var response = await getData(paramUri: "${ApiConstant.employeeGetHourRequest}searchName=$search&page=$page");
    if (response["status"] == "True") {
      return EmployeeGetHourRequestModel.fromJson(response);
    } else {
      return null;
    }
  }
}
