import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/EmployeeModel/employee_edit_estimate_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';
import '../../Screens/Contractors/ManageConstruction/manage_constroction.dart';

class CompanyEditEstimateController {
  //EmployeeEditEstimateModel? addEstimateModel;
  CompanyEditEstimateModel? companyEditEstimateModel;
  TextEditingController contactId = TextEditingController();
  TextEditingController estimateName = TextEditingController();
  TextEditingController estimateDescription = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController tax = TextEditingController();

  Future editEstimate(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.CompanyEditEstimate + id,
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
      var res = CompanyEditEstimateModel.fromJson(response);
      companyEditEstimateModel = res;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ManageConstruction(
      //             profilePic: prefs.get("profilePic").toString())));
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
