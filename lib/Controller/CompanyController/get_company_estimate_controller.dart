import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_estimate_model.dart';
import '../../Network/api_constant.dart';

class GetCompanyEstimateController {
  Future<CompanyEstimateModel> getCompanyEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyOrder);
    return CompanyEstimateModel.fromJson(response);
  }
}
