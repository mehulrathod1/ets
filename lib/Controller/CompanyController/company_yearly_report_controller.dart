import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_yearly_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyYearlyReportController {
  Future getYearlyReport(BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyYearlyReport + id);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyYearlyReportModel.fromJson(response);
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
