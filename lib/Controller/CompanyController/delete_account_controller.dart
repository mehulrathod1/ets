import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../Models/CompanyModels/delete_company_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class DeleteAccount {
  DeleteCompanyModel? deleteCompanyModel;
  Future deleteAccount(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(paramUri: ApiConstant.deleteCompany);
    debugPrint("deleteContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = DeleteCompanyModel.fromJson(response);
      deleteCompanyModel = res;
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
