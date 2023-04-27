import 'package:etsemployee/Models/CompanyModels/company_estimate_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class GetCompanyEstimateController {
  Future<CompanyEstimateModel> getCompanyEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyEstimate);
    return CompanyEstimateModel.fromJson(response);
  }
}
