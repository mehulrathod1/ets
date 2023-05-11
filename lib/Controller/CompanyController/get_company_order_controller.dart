import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/get_company_order.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class GetCompanyOrderController {
  Future getAllCompanyOrder(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyOrder);
    if (response["status"] == "True" && response["data"] != null) {
      return GetCompanyOrderModel.fromJson(response);
    } else {
      return null;
    }
  }
}
