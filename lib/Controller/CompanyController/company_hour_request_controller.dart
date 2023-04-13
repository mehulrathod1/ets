import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/companay_hour_request.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyFixHourRequestController {
  Future<CompanyHourRequestModel> getHourRequest(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyFixHourRequest);
    return CompanyHourRequestModel.fromJson(response);
  }
}
