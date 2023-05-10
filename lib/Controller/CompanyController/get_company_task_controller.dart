import 'package:etsemployee/Models/CompanyModels/get_company_task_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class GetCompanyTaskController {
  Future getAllCompanyTask(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyTask);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyTaskModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future getTaskOrderList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyTaskOrder);
    if (response["status"] == "True" && response["data"]["List"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
