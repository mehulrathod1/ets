import 'package:etsemployee/Models/CompanyModels/get_company_order.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class GetCompanyOrderController {
  Future getAllCompanyOrder(BuildContext context,
      {String? search, int? page}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.getCompanyOrder}searchName=$search&page=$page");
    if (response["status"] == "True" && response["data"] != null) {
      return GetCompanyOrderModel.fromJson(response);
    } else {
      return null;
    }
  }
}
