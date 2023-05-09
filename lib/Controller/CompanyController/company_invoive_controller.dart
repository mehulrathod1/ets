import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyInvoiceController {
  Future<CompanyAllInvoiceModel> getCompanyInvoice(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyAllInvoice);
    return CompanyAllInvoiceModel.fromJson(response);
  }

  Future getEstimateForInvoiceList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyInvoiceFor);
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
