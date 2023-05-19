import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_edit_employee_list_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEditAttendanceListController {
  Future getEditAttendance(BuildContext context, String id, String date) async {
    var response = await getData(
        paramUri: '${ApiConstant.companyEditAttendanceList}$id/$date');
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyEditAttendanceListModel.fromJson(response);
    } else {
      return null;
    }
  }
}
