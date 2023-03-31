import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_delete_task_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyDeleteTaskController {
  Future<CompanyDeleteTaskModel> deleteTask(
      BuildContext context, String id) async {
    var response = await getData(paramUri: ApiConstant.companyDeleteTask + id);

    print(response);

    var res = CompanyDeleteTaskModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: const Duration(seconds: 2),
    ));
    return res;
  }
}
