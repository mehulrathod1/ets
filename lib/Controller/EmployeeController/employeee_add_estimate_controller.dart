import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/EmployeeModel/employee_add_estimate_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';
import '../../Screens/Contractors/ManageConstruction/manage_constroction.dart';

class EmployeeAddEstimateController {
  EmployeeAddEstimateModel? addEstimateModel;
  TextEditingController dueDate = TextEditingController();
  TextEditingController contactId = TextEditingController();
  TextEditingController estimateName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController estimateDescription = TextEditingController();

  Future addEstimate(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeAddEstimate,
        params: {
          'contact': contactId.text,
          'estimate_name': estimateName.text,
          'due_date': dueDate.text,
          'amount': amount.text,
          'markup': markup.text,
          'tax': tax.text,
          'estimate_description': estimateDescription.text,
        });
    debugPrint("addContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeAddEstimateModel.fromJson(response);
      addEstimateModel = res;
      Navigator.pop(context);

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ManageConstruction(
      //             profilePic: prefs.get("profilePic").toString())));
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

  Future getContactListForEstimate(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.employeeEstimateContact);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
