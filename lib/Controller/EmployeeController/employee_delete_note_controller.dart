import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/EmployeeModel/employee_delete_note_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeDeleteNoteController {
  Future<EmployeeDeleteNoteModel> deleteNote(
      BuildContext context, String id) async {
    var response = await getData(paramUri: ApiConstant.employeeDeleteNote + id);

    print(response);

    var res = EmployeeDeleteNoteModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
