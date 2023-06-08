// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/CompanyPortal/CompanyContractors/ManageCompanyNotes/manage_company_note.dart';
import 'package:etsemployee/Models/CompanyModels/company_add_note_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class CompanyAddNoteController {
  CompanyAddNoteModel? addNoteModel;
  TextEditingController noteStatus = TextEditingController();
  TextEditingController noteName = TextEditingController();
  TextEditingController noteDescription = TextEditingController();
  TextEditingController employeeList = TextEditingController();

  Future addCompanyNote(BuildContext context,
      {required String? employeeId}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await postDataWithHeader(paramUri: ApiConstant.companyAddNote, params: {
      'notestatus': noteStatus.text,
      'note_name': noteName.text,
      'note_description': noteDescription.text,
      'employeelist': employeeId!,
    });
    if (response["status"] == 'True') {
      var res = CompanyAddNoteModel.fromJson(response);
      addNoteModel = res;
      Navigator.pop(context);
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => const ManageCompanyNote()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
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

  Future getEmployeeListForCompany(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyEmployeeList);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"];
    } else {
      return null;
    }
  }
}
