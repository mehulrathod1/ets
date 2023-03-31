import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_delete_contact_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyDeleteContactController {
  Future<CompanyDeleteContactModel> deleteContact(
      BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyDeleteContact + id);

    print(response);

    var res = CompanyDeleteContactModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
