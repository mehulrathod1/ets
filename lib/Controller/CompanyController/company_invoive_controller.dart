import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyInvoiceController {
  Future getCompanyInvoice(BuildContext context,
      {String? search, int? page}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.companyAllInvoice}searchName=$search&page=$page");
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyAllInvoiceModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future getEstimateForInvoiceList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyInvoiceFor);
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }

  Future getCompanyEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyEstimate);
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
