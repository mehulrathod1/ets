import 'package:etsemployee/Models/CompanyModels/get_company_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class GetCompanyTaskController {
  Future<CompanyTaskModel> getAllCompanyTaks(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyTask);
    return CompanyTaskModel.fromJson(response);
  }
}
