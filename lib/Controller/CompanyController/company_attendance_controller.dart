import 'package:etsemployee/Models/CompanyModels/company_view_arttendance_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyAttendanceController {
  Future<CompanyAttendanceModel> getAttendance(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyViewAttendance + id);
    return CompanyAttendanceModel.fromJson(response);
  }
}
