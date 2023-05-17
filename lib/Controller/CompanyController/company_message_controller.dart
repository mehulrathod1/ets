import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_message_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyMessageController {
  Future getMessage(BuildContext context, String id) async {
    var response = await getData(paramUri: ApiConstant.companyMessage + id);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyMessageModel.fromJson(response);
    } else {
      return null;
    }
  }
}
