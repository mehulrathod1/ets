import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/companay_hour_request.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyFixHourRequestController {
  Future getHourRequest(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyFixHourRequest);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyHourRequestModel.fromJson(response);
      return null;
    }
  }
}
