import 'package:etsemployee/Models/CompanyModels/company_view_image_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyImageController {
  Future<CompanyViewImageModel> getImage(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewImage);
    var res = CompanyViewImageModel.fromJson(response);
    return res;
  }
}
