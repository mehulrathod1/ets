import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/companyAcceptHourModel.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAcceptHourController {
  Future<CompanyHourAcceptModel> acceptHourRequest(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.cmpAcceptHourRequest + id);

    print(response);

    var res = CompanyHourAcceptModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
