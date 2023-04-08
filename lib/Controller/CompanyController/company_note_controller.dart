import 'package:etsemployee/Models/CompanyModels/company_note_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyNoteController {
  Future<CompanyNoteModel> getAllCompanyOrder(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyNoteList);
    return CompanyNoteModel.fromJson(response);
  }
}
