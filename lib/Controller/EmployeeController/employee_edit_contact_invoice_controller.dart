import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/EmployeeModel/employee_edit_contact_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';
import '../../Screens/Contractors/ManageInvoice/manage_contact_invoice.dart';

class EmployeeEditContactInvoiceController {
  EmployeeEditContactInvoiceModel? editContactInvoiceModel;
  TextEditingController id = TextEditingController();

  TextEditingController contactId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController signName = TextEditingController();

  Future editContactInvoice(BuildContext context,
      {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeEditInvoiceForContact,
        params: {
          'id': id.text,
          'description': description.text,
          'amount': amount.text,
          'invoice_date': invoiceDate.text,
          'signature_name': signName.text,
          'signature': signature!,
          'contact_id': contactId.text
        });
    debugPrint("invoice response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeEditContactInvoiceModel.fromJson(response);
      editContactInvoiceModel = res;
      Navigator.pop(context);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmployeeManageContactInvoice(
                  profilePic: prefs.get("profilePic").toString())));

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

  Future getContact(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.employeeContactListForInvoice);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
