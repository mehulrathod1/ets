import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../CompanyPortal/CompanyContractors/ManageCompanyNotes/manage_company_note.dart';
import '../../Network/api_constant.dart';

import '../../Network/post_api_client.dart';

class CompanyEditNoteController {
  TextEditingController noteStatus = TextEditingController();
  TextEditingController noteName = TextEditingController();
  TextEditingController noteDescription = TextEditingController();
  TextEditingController noteEmployee = TextEditingController();

  Future editNote(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditNote + id,
        params: {
          'notestatus': noteStatus.text,
          'note_name': noteName.text,
          'note_description': noteDescription.text,
          'employeelist': '',
        });
    debugPrint("editNote response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => const ManageCompanyNote()));
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
