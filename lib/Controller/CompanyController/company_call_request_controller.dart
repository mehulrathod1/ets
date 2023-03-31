import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_call_request.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyCallRequestController {
  Future<CompanyCallRequestModel> sendCallRequest(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.sendCallRequest);

    var res = CompanyCallRequestModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: Duration(seconds: 2),
    ));

    return res;
  }
}
