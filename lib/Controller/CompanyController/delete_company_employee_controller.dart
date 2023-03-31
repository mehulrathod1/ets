import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/detlet_company_employee_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class DeleteCompanyEmployeeController {
  Future<DeleteCompanyEmployeeModel> getAllCompanyOrder(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.getCompanyOrder);
    return DeleteCompanyEmployeeModel.fromJson(response);
  }
}
