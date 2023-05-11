import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/GetCompanyEmployeeModel.dart';
import '../../Models/CompanyModels/company_inbox_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyInboxController {
  Future getCompanyInbox(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyInbox);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyInboxModel.fromJson(response);
    } else {
      return null;
    }
  }
}
