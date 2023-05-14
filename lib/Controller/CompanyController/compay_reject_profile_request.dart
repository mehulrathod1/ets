import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyRejectProfileRequest {
  Future rejectProfileRequest(
      BuildContext context, String id, String empId) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyrejectProfileRequest,
        params: {
          'id': id,
          'empid': empId,
        });
    debugPrint(" response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);

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
