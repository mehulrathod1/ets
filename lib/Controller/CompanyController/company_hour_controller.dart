import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_hour_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyHourController {
  Future<CompanyHourModel> getHour(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewHours);

    var res = CompanyHourModel.fromJson(response);

    return res;
  }
}
