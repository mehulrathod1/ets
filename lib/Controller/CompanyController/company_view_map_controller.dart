import 'package:etsemployee/Models/CompanyModels/company_view_map_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyMapController {
  Future getMap(BuildContext context, String id, String date) async {
    var response =
        await getData(paramUri: '${ApiConstant.companyViewMap}$id/$date');

    if (response["status"] == "True" && response["data"] != null) {
      return CompanyViewMapModel.fromJson(response);
    } else {
      return null;
    }
  }
}
