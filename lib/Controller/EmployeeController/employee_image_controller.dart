import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_view_image.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeImage {
  Future<EmployeeViewImageModel> getEmployeeImage(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetImage);

    print(response);

    return EmployeeViewImageModel.fromJson(response);
  }
}
