import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/GetCompanyEmployeeModel.dart';
import '../../Models/CompanyModels/company_inbox_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyInboxController {
  Future getCompanyInbox1(BuildContext context)async {
    var response = await getData(paramUri:"${ApiConstant.companyInbox}");//searchName=$search&page=$page
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyInboxModel.fromJson(response);
    } else {
      return null;
    }
  }
  Future getCompanyInbox(BuildContext context,{String? search}) async {
    var response = await getData(paramUri:"${ApiConstant.companyInbox}?searchName=$search");//searchName=$search&page=$page
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyInboxModel.fromJson(response);
    } else {
      return null;
    }
  }
}
