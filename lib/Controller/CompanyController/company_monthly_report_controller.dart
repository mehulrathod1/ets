import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_monthly_report.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyMonthlyReportController {
  Future<CompanyMonthlyReportModel> getMonthlyReport(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyMonthlyReport + id);
    return CompanyMonthlyReportModel.fromJson(response);
  }
}
