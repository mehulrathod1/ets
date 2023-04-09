import 'package:etsemployee/Models/CompanyModels/company_contacts_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyContactController {
  Future<CompanyContactModel> getCompanyContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyContacts);
    return CompanyContactModel.fromJson(response);
  }
}
