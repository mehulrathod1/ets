import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_yearly_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyYearlyReportController {
  Future<CompanyYearlyReportModel> getYearlyReport(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyYearlyReport + id);
    return CompanyYearlyReportModel.fromJson(response);
  }
}
