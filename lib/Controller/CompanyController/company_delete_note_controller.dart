// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/CompanyModels/company_delete_note_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class CompanyDeleteNoteController {
  CompanyDeleteNoteModel? deleteNoteModel;

  Future deleteNote(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(paramUri: ApiConstant.companyDeleteNote + id);
    debugPrint("deleteContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyDeleteNoteModel.fromJson(response);
      deleteNoteModel = res;
      Navigator.pop(context);
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
}
