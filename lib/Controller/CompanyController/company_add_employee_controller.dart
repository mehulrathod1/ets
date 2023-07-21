import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyScreens/employee_management.dart';
import '../../Models/CompanyModels/company_add_employee_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddEmployeeController {
  CompanyAddEmployeeModel? addEmployeeModel;
  TextEditingController employeeName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController creditCardNo = TextEditingController();
  TextEditingController creditCardName = TextEditingController();
  TextEditingController creditCardExpDate = TextEditingController();
  TextEditingController securityCode = TextEditingController();

  Future addEmployee(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddEmployee,
        params: {
          'employee_name': employeeName.text,
          'email': email.text,
          'department': department.text,
          'profile_img': "",
          'creditcard_no': creditCardNo.text,
          'creditcard_name': creditCardName.text,
          'creditcard_exp_date': creditCardExpDate.text,
          'security_code': securityCode.text,
        });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddEmployeeModel.fromJson(response);
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

  Future getDepartmentList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyDepartment);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"];
    } else {
      return null;
    }
  }
}
