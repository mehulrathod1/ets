import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/GetCompanyEmployeeModel.dart';

class GetCompanyEmployeeController {
  // late Map<String, dynamic> doctors;

  Future<GetCompanyEmployeeModel> getCompanyEmployee(
      BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyAllEmployee);

    print(response);

    return GetCompanyEmployeeModel.fromJson(response);
  }
}
