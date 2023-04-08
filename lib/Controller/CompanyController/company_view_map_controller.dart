import 'package:etsemployee/Models/CompanyModels/company_view_map_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyMapController {
  Future<CompanyViewMapModel> getMap(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewMap);
    var res = CompanyViewMapModel.fromJson(response);
    return res;
  }
}
