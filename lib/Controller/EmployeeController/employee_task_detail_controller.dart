import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_task_detail_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeTaskDetailController {
  Future<EmployeeTaskDetailModel> getTaskDetail(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeTaskDetail);

    print(response);
    return EmployeeTaskDetailModel.fromJson(response);
  }
}
