import 'package:etsemployee/Models/SalesModel/sales_agent_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class SalesAgentController {
  Future<SalesAgentModel> getAgent(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.salesAgent);
    debugPrint(response);
    return SalesAgentModel.fromJson(response);
  }
}
