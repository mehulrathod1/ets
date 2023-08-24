import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_get_question_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyGetQuestionController {
  Future getCompanyQuestion(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.companyGetSecurityQuestion);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyGetQuestionModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future getEmployeeQuestion(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.employeeGetSecurityQuestion);
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyGetQuestionModel.fromJson(response);
    } else {
      return null;
    }
  }
}
