import 'package:flutter/cupertino.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeAddInvoiceController {
  TextEditingController invoiceForId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController estimateAmount = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController orderAmount = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController paidAmount = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController costPlus = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();

  Future getEmployeeEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeEstimateList);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
