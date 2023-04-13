import 'package:etsemployee/Models/EmployeeModel/employee_invoice_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeInvoiceController {
  Future getEmployeeInvoice(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeInvoice);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeInvoiceModel.fromJson(response);
    } else {
      return null;
    }
  }
}
