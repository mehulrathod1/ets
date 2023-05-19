import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_delete_estimate_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyDeleteEstimateController {
  CompanyDeleteEstimateModel? deleteEstimateModel;

  Future deleteEstimate(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.companyDeleteEstimate + id);
    debugPrint("deleteOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyDeleteEstimateModel.fromJson(response);
      deleteEstimateModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
