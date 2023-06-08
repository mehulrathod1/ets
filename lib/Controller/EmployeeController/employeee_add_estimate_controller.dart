import 'package:flutter/cupertino.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeAddEstimateController {
  TextEditingController dueDate = TextEditingController();

  Future getContactListForEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeEstimateContact);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
