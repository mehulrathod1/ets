import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_hour_reject_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class ClassHourRejectController {
  Future rejectHourRequest(BuildContext context, String id) async {
    CompanyHourRejectModel? rejectModel;

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var response = await postDataWithHeader(
        paramUri: ApiConstant.cmpRejectHourRequest,
        params: {
          'id': id,
          'request_id': '2',
        });
    if (response["status"] == 'True') {
      var res = CompanyHourRejectModel.fromJson(response);
      rejectModel = res;
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
