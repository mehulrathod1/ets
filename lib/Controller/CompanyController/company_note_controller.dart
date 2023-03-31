import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_note_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyNoteController {
  Future<CompanyNoteModel> getAllCompanyOrder(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyNoteList);

    return CompanyNoteModel.fromJson(response);
  }
}
