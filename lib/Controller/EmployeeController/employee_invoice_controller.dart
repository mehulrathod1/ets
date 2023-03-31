import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/employee_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeInvoiceController {
  Future<EmployeeInvoiceModel> getEmployeeInvoice(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeInvoice);

    print(response);
    return EmployeeInvoiceModel.fromJson(response);
  }
}
