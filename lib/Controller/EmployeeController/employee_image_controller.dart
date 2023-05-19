import 'package:etsemployee/Models/EmployeeModel/employee_view_image.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeImage {
  Future<EmployeeViewImageModel> getEmployeeImage(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeGetImage);
    return EmployeeViewImageModel.fromJson(response);
  }
}
