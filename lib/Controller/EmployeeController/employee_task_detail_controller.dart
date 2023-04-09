import 'package:etsemployee/Models/EmployeeModel/employee_task_detail_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeTaskDetailController {
  Future<EmployeeTaskDetailModel> getTaskDetail(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeTaskDetail);
    return EmployeeTaskDetailModel.fromJson(response);
  }
}
