import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyContractors/ManageCompanyInvoice/company_manage_contact_invoice.dart';
import '../../Models/CompanyModels/company_contact_invoice_model.dart';
import '../../Models/EmployeeModel/employee_add_invoiice_for_contact.dart';
import '../../Models/EmployeeModel/employee_edit_contact_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class ManageCompanyContactInvoice {
  EmployeeAddInvoiceForContactModel? addInvoiceForContactModel;

  EmployeeEditContactInvoiceModel? editContactInvoiceModel;
  TextEditingController id = TextEditingController();

  TextEditingController contactId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController signName = TextEditingController();

  Future getContactInvoice(BuildContext context) async {
    var response =
        await getData(paramUri: ApiConstant.companyGetContactInvoice);

    if (response["status"] == "True" && response["data"] != null) {
      return CompanyGetInvoiceContactModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<bool> deleteContactInvoice({BuildContext? context, String? id}) async {
    showDialog(
        context: context!,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeContactInvoice + id!);
    if (response["status"] == "True" && response["data"] != null) {
      Navigator.pop(context);

      return true;
    } else {
      Navigator.pop(context);
      return false;
    }
  }

  Future addContactInvoice(BuildContext context,
      {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddInvoiceForContact,
        params: {
          'contact_id': contactId.text,
          'description': description.text,
          'amount': amount.text,
          'invoice_date': invoiceDate.text,
          'signature_name': signName.text,
          'signature': signature!,
        });
    debugPrint("invoice response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeAddInvoiceForContactModel.fromJson(response);
      addInvoiceForContactModel = res;
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CompanyManageContactInvoice()));

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
    var response = await getData(paramUri: ApiConstant.companyContactsList);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }

  Future editContactInvoice(BuildContext context,
      {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditInvoiceForContact,
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

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CompanyManageContactInvoice()));

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
