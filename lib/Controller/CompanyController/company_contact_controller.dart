import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_contacts_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyContactController {
  Future<CompanyContactModel> getCompanyContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyContacts);

    var res = CompanyContactModel.fromJson(response);

    return res;
  }
}
