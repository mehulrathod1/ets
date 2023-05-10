import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_estimate_model.dart';
import '../../Network/api_constant.dart';

class GetCompanyEstimateController {
  Future getCompanyEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyEstimate);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyEstimateModel.fromJson(response);
    } else {
      return null;
    }
  }
}
