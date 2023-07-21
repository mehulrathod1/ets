import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyScreens/employee_management.dart';
import '../../Models/CompanyModels/company_edit_employee_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEditEmployeeController {
  CompanyEditEmployeeModel? addEmployeeModel;

  TextEditingController employeeName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController employeeId = TextEditingController();
  TextEditingController password = TextEditingController();

  Future editEmployee(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditEmployee,
        params: {
          'email': email.text,
          'employee_name': employeeName.text,
          'password': password.text,
          'department': department.text,
          'employee_id': employeeId.text,
          'profile_img': "",
        });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyEditEmployeeModel.fromJson(response);
      addEmployeeModel = res;
      Navigator.pop(context);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => EmployeeManagement(
      //               appBar: true,
      //             )));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
