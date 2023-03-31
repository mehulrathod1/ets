import 'package:flutter/cupertino.dart';

import '../../Models/EmployeeModel/add_employee_note_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeAddNoteController {
  TextEditingController noteStatus = TextEditingController();
  TextEditingController noteName = TextEditingController();
  TextEditingController noteDescription = TextEditingController();
  TextEditingController employeeList = TextEditingController();

  Future<EmployeeAddNoteModel> addCompanyContact(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.addCompanyContacts,
        params: {
          'notestatus': noteStatus.text,
          'note_name': noteName.text,
          'note_description': noteDescription.text,
          'employeelist': employeeList.text,
        });
    var res = EmployeeAddNoteModel.fromJson(response);
    print(res.message);
    return res;
  }
}
