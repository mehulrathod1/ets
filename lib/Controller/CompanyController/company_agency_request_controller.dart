import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_agency_request_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAgencyRequestController {
  Future getAgencyRequest(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyAgencyRequest);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyAgencyRequestModel.fromJson(response);
    } else {
      return null;
    }
  }
}
