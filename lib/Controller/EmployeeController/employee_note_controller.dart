// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_add_note_model.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_notes_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:etsemployee/Screens/Contractors/ManageNotes/manage_notes.dart';
import 'package:flutter/material.dart';

class EmployeeNoteController {
  EmployeeAddNoteModel? employeeAddNoteModel;
  TextEditingController noteName = TextEditingController();
  TextEditingController noteDescription = TextEditingController();

  Future getEmployeeContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeNoteList);
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeNoteModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future addNotes(
    BuildContext context, {
    bool markAsComplete = false,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeAddNote, params: {
      'note_name': noteName.text,
      'note_description': noteDescription.text,
      'notestatus': markAsComplete ? "1" : "0",
    });
    debugPrint("addNotes response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeAddNoteModel.fromJson(response);
      employeeAddNoteModel = res;
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageNote()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future editNotes(BuildContext context, {bool markAsComplete = false, String? id}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeEditNote + id!, params: {
      'note_name': noteName.text,
      'note_description': noteDescription.text,
      'notestatus': markAsComplete ? "1" : "0",
    });
    debugPrint("editNotes response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageNote()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
