import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_subscription_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanySubscriptionController {
  CompanySubscriptionModel? subscriptionModel;

  Future addSubscription(BuildContext context,
      {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companySubscription,
        params: {
          'sig-dataUrl': signature!,
        });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanySubscriptionModel.fromJson(response);
      subscriptionModel = res;
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
