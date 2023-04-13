import 'package:etsemployee/Models/EmployeeModel/employee_estimate_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeEstimateController {
  Future getEmployeeEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeEstimateList);
    if (response["status"] == "True" && response["data"] != null) {
      print("DATA :- ${response["data"]}");
      return EmployeeEstimateModel.fromJson(response);
    } else {
      return null;
    }
  }
}
