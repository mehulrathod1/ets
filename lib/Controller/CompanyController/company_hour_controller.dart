import 'package:etsemployee/Models/CompanyModels/company_hour_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyHourController {
  Future<CompanyHourModel> getHour(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewHours);
    return CompanyHourModel.fromJson(response);
  }
}
