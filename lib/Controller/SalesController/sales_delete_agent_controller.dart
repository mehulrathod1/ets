// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/SalesModel/sales_delete_agent_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class SalesAgentDeleteController {
  Future<SalesDeleteAgentModel> deleteAgent(BuildContext context, String id) async {
    var response = await getData(paramUri: ApiConstant.salesDeleteAgent + id);
    var res = SalesDeleteAgentModel.fromJson(response);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res.message),
        duration: const Duration(seconds: 2),
      ),
    );
    return res;
  }
}
