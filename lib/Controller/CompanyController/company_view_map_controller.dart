import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_view_map_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyMapController {
  Future<CompanyViewMapModel> getMap(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewMap);

    var res = CompanyViewMapModel.fromJson(response);

    return res;
  }
}
