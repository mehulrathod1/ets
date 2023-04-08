import 'package:etsemployee/Models/EmployeeModel/employee_map_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeMapController {
  Future<EmployeeViewMapModel> getAttendanceHistory(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetMap);
    debugPrint(response);
    return EmployeeViewMapModel.fromJson(response);
  }
}
