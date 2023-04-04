import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/SalesModel/sales_delete_agent_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class SalesAgentDeleteController {
  Future<SalesDeleteAgentModel> deleteAgent(
      BuildContext context, String id) async {
    var response = await getData(paramUri: ApiConstant.salesDeleteAgent + id);

    print(response);

    var res = SalesDeleteAgentModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
