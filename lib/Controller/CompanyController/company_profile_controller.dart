import 'package:etsemployee/Models/CompanyModels/company_profile_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class CompanyProfileController {
  Future<CompanyProfileModel> getCompanyProfile(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyProfile);
    return CompanyProfileModel.fromJson(response);
  }
}
