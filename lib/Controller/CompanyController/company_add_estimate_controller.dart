import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyContractors/ManageCompanyEstimetes/company_estimeates.dart';
import '../../Models/CompanyModels/company_add_estimate_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddEstimateController {
  CompanyAddEstimateModel? addEstimateModel;

  TextEditingController contactId = TextEditingController();
  TextEditingController estimateName = TextEditingController();
  TextEditingController estimateDescription = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController employeeList = TextEditingController();

  Future addEstimate(BuildContext context,
      {required String? employeeId}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddEstimate,
        params: {
          'contact': contactId.text,
          'estimate_name': estimateName.text,
          'estimate_description': estimateDescription.text,
          'due_date': dueDate.text,
          'amount': amount.text,
          'markup': markup.text,
          'tax': tax.text,
          'employeelist': employeeId!,
        });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddEstimateModel.fromJson(response);
      addEstimateModel = res;
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CompanyEstimate()));

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

  Future companyGetContactListForEstimate(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.companyGetContactForEstimate);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }

  Future getEmployeeListForCompany(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyEmployeeList);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"];
    } else {
      return null;
    }
  }
}
