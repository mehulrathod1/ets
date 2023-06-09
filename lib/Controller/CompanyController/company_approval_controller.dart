import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_approval_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyApprovalController {
  Future getApproval(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyApprovals);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyApprovalModel.fromJson(response);
    } else {
      return null;
    }
  }
}
