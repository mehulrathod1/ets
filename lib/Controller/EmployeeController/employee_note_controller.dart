import 'package:etsemployee/Models/EmployeeModel/employee_notes_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeNoteController {
  Future getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeNoteList);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeNoteModel.fromJson(response);
    } else {
      return null;
    }
  }
}
