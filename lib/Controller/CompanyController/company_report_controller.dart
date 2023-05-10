import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_report_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyReportController {
  Future getAllReport(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyAllReport);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyReportModel.fromJson(response);
    } else {
      return null;
    }
  }
}
