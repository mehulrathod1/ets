import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_hour_reject_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class ClassHourRejectController {
  Future<CompanyHourRejectModel> rejectHourRequest(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.cmpRejectHourRequest + id);

    print(response);

    var res = CompanyHourRejectModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
