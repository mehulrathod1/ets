import 'package:etsemployee/Models/EmployeeModel/employee_view_image.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeImage {
  Future getEmployeeImage(BuildContext context, String date) async {
    var response = await getData(paramUri: ApiConstant.employeeGetImage + date);

    if (response["status"] == "True") {
      return EmployeeViewImageModel.fromJson(response);
    } else {
      return null;
    }
  }
}
