import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_add_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddInvoiceController {
  CompanyAddInvoiceModel? addInvoiceModel;

  TextEditingController invoiceForId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController estimateAmount = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController orderAmount = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController paidAmount = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController costPlus = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController isPaid = TextEditingController();

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
          'sign_name': 'signature',
          'total': totalAmount.text,
        });
    debugPrint("invoice response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddInvoiceModel.fromJson(response);
      addInvoiceModel = res;
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
