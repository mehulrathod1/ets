// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeShareLocationController {
  Future<bool> startShareLocation(BuildContext context, String address) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeStartSharingLocation, params: {'location': address});
    debugPrint("startShareLocation response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      return true;
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<bool> stopShareLocation(BuildContext context, String address) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeStopSharingLocation, params: {'location': address});
    debugPrint("stopShareLocation response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      return true;
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    }
  }
}
