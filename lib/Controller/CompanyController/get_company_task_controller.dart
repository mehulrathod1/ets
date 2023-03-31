import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/get_company_task_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class GetCompanyTaskController {
  Future<CompanyTaskModel> getAllCompanyTaks(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyTask);
    return CompanyTaskModel.fromJson(response);
  }
}
