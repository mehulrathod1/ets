import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_view_arttendance_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAttendanceController {
  Future<CompanyAttendanceModel> getAttendance(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewAttendance);

    var res = CompanyAttendanceModel.fromJson(response);

    return res;
  }
}
