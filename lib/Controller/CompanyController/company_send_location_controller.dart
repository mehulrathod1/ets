import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_send_location_request_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyLocationRequestController {
  Future<CompanyLocationRequestModel> sendLocationRequest(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.sendLocationRequest);

    var res = CompanyLocationRequestModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: Duration(seconds: 2),
    ));

    return res;
  }
}
