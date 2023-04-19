import 'package:etsemployee/Models/CompanyModels/company_add_note_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeAddNoteController {
  TextEditingController noteStatus = TextEditingController();
  TextEditingController noteName = TextEditingController();
  TextEditingController noteDescription = TextEditingController();
  TextEditingController employeeList = TextEditingController();

  Future<CompanyAddNoteModel> addCompanyContact(BuildContext context) async {
    var response = await postDataWithHeader(paramUri: ApiConstant.addCompanyContacts, params: {
      'notestatus': noteStatus.text,
      'note_name': noteName.text,
      'note_description': noteDescription.text,
      'employeelist': employeeList.text,
    });
    return CompanyAddNoteModel.fromJson(response);
  }
}
