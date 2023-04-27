import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_department_detail_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyDepartmentDetailController {
  TextEditingController departmentName = TextEditingController();

  Future<CompanyDepartmentDetailModel> getDepartmentDetail(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyGetDepartmentDetail + id);
    var res = CompanyDepartmentDetailModel.fromJson(response);
    departmentName.text = res.data.first.departmentName.toString();
    return res;
  }
}
