import 'package:etsemployee/Models/EmployeeModel/employee_invoice_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeInvoiceController {
  Future<EmployeeInvoiceModel> getEmployeeInvoice(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeInvoice);
    debugPrint(response);
    return EmployeeInvoiceModel.fromJson(response);
  }
}
