import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_monthly_report.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyMonthlyReportController {
  Future getMonthlyReport(BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyMonthlyReport + id);
    // return CompanyMonthlyReportModel.fromJson(response);

    if (response["status"] == "True" && response["data"] != null) {
      return CompanyMonthlyReportModel.fromJson(response);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }
}
