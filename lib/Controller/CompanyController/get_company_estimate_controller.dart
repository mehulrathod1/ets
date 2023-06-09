import 'package:etsemployee/Models/CompanyModels/company_estimate_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class GetCompanyEstimateController {
  Future getCompanyEstimate(BuildContext context,
      {String? search, int? page}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.getCompanyEstimate}searchName=$search&page=$page");
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyEstimateModel.fromJson(response);
    } else {
      return null;
    }
  }
}
