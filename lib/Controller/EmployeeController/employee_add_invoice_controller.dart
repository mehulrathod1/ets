import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/EmployeeModel/employee_add_estimate_model.dart';
import '../../Models/EmployeeModel/employee_add_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';
import '../../Screens/Contractors/ManageInvoice/manage_invoice.dart';

class EmployeeAddInvoiceController {
  EmployeeAddInvoiceModel? addInvoiceModel;
  TextEditingController invoiceForId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController estimateAmount = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController orderAmount = TextEditingController();
  TextEditingController changeOrderAmount = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController paidAmount = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController costPlus = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController isPaid = TextEditingController();
  TextEditingController signName = TextEditingController();

  Future addInvoice(BuildContext context, {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeAddInvoice,
        params: {
          'sig-dataUrl': signature!,
          'estimate_id': invoiceForId.text,
          'invoice_description': description.text,
          'amount': estimateAmount.text,
          'paid_by': 'test account',
          'tax': tax.text,
          'cost_plus': costPlus.text,
          'invoice_date': invoiceDate.text,
          'isPaid': isPaid.text,
          'sign_name': signName.text,
          'total': totalAmount.text
        });
    debugPrint("invoice response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeAddInvoiceModel.fromJson(response);
      addInvoiceModel = res;
      Navigator.pop(context);

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ManageInvoice(
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

  Future getEmployeeEstimate(BuildContext context) async {
    var response = await getData(
        paramUri: ApiConstant.employeeEstimateListInvoiceDropdown);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
