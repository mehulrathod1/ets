import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyContractors/ManageCompanyInvoice/manage_company_invoice.dart';
import '../../Models/CompanyModels/company_add_invoice_model.dart';
import '../../Models/CompanyModels/company_edit_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddInvoiceController {
  CompanyAddInvoiceModel? addInvoiceModel;
  CompanyEditInvoiceModel? editInvoiceModel;
  TextEditingController invoiceForId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController estimateAmount = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController paidAmount = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController costPlus = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController isPaid = TextEditingController();
  TextEditingController signatureName = TextEditingController();
  TextEditingController amountNow = TextEditingController();
  TextEditingController paidBy = TextEditingController();
  TextEditingController orderAmount = TextEditingController();
  TextEditingController dueAmount = TextEditingController();

  Future addInvoice(BuildContext context, {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddInvoice,
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
          'sign_name': signatureName.text,
          'total': totalAmount.text,
        });
    debugPrint("invoice response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddInvoiceModel.fromJson(response);
      addInvoiceModel = res;
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ManageCompanyInvoice()));

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

  Future editInvoice(BuildContext context, String id, String signature) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditInvoice + id,
        params: {
          'estimate_id': invoiceForId.text,
          'sig-dataUrl': signature,
          'invoice_description': description.text,
          'amount': estimateAmount.text,
          'paid_by': paidBy.text,
          'tax': tax.text,
          'cost_plus': costPlus.text,
          'invoice_date': invoiceDate.text,
          'isPaid': isPaid.text,
          'sign_name': signatureName.text,
          'amount_now': amountNow.text,
          'total': totalAmount.text,
        });
    debugPrint("invoice response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddInvoiceModel.fromJson(response);
      addInvoiceModel = res;
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ManageCompanyInvoice()));

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
