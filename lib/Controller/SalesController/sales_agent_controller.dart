import 'package:flutter/cupertino.dart';

import '../../Models/SalesModel/sales_agent_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class SalesAgentController {
  Future<SalesAgentModel> getAgent(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.salesAgent);
    print(response);
    return SalesAgentModel.fromJson(response);
  }
}
