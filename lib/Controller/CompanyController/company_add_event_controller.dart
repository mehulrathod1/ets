import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/compnay_add_event_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddEventController {
  CompanyAddEventModel? addEventModel;

  TextEditingController eventName = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController evtStart = TextEditingController();
  TextEditingController evtEnd = TextEditingController();

  Future addEvent(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddEvent,
        params: {
          'event_id': '11251',
          'event_name': eventName.text,
          'event_description': eventDescription.text,
          'evtStart': eventName.text,
          'evtEnd': evtEnd.text,
          'employeelist': '',
        });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddEventModel.fromJson(response);
      addEventModel = res;
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
