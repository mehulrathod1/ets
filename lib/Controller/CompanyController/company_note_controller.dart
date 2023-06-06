import 'package:etsemployee/Models/CompanyModels/company_note_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class CompanyNoteController {
  Future getAllCompanyNote(BuildContext context,
      {String? search, int? page}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.companyNoteList}searchName=$search&page=$page");
    if (response["status"] == "True" && response["data"] != null) {
      return CompanyNoteModel.fromJson(response);
    } else {
      return null;
    }
  }
}
