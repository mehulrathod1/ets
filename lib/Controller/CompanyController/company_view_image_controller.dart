import 'package:etsemployee/Models/CompanyModels/company_view_image_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyImageController {
  Future getAttendanceImage(
      BuildContext context, String id, String date) async {
    var response =
        await getData(paramUri: '${ApiConstant.companyViewImage}$id/$date');
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyViewImageModel.fromJson(response);
    } else {
      return null;
    }
  }
}
