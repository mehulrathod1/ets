// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeAddEventController {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController eventName = TextEditingController();
  TextEditingController eventDescription = TextEditingController();

  Future addEvent(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeAddEvent, params: {'evtStart': startDate.text, 'evtEnd': endDate.text, 'event_name': eventName.text, 'event_description': eventDescription.text});
    debugPrint("addEvent response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      startDate.clear();
      endDate.clear();
      eventName.clear();
      eventDescription.clear();
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
