import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_view_image_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyImageController {
  Future<CompanyViewImageModel> getImage(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyViewImage);

    var res = CompanyViewImageModel.fromJson(response);

    return res;
  }
}
