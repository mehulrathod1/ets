import 'package:etsemployee/Models/EmployeeModel/add_employee_note_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

class EmployeeAddNoteController {
  TextEditingController noteStatus = TextEditingController();
  TextEditingController noteName = TextEditingController();
  TextEditingController noteDescription = TextEditingController();
  TextEditingController employeeList = TextEditingController();

  Future<EmployeeAddNoteModel> addCompanyContact(BuildContext context) async {
    var response = await postDataWithHeader(paramUri: ApiConstant.addCompanyContacts, params: {
      'notestatus': noteStatus.text,
      'note_name': noteName.text,
      'note_description': noteDescription.text,
      'employeelist': employeeList.text,
    });
    var res = EmployeeAddNoteModel.fromJson(response);
    debugPrint(res.message);
    return res;
  }
}
