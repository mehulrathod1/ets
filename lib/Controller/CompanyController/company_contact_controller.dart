import 'package:etsemployee/Models/CompanyModels/company_contacts_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyContactController {
  Future getCompanyContact(BuildContext context,
      {String? search, int? page}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.companyContacts}searchName=$search&page=$page");
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyContactModel.fromJson(response);
    } else {
      return null;
    }
  }
}
