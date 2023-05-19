import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_hole_employee_moel.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyHoldAccessController {
  HoldAccessEmployee? holdAccessEmployee;

  Future holdAccess(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.companyHoldAccessEmployee + id);
    debugPrint("sendLocationRequest response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = HoldAccessEmployee.fromJson(response);
      holdAccessEmployee = res;
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
