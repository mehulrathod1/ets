import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_profile_model.dart';

class CompanyProfileController {
  Future<CompanyProfileModel> getCompanyProfile(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyProfile);

    // var res = CompanyProfileModel.fromJson(response);
    // var s = res.data as Map<String, dynamic>;
    // return loginModelFromJson(response.data as Map<String, dynamic>);

    return CompanyProfileModel.fromJson(response);
  }
}
