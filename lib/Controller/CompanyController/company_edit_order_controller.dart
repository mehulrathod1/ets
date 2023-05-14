// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/CompanyPortal/CompanyContractors/ManageCompanyOrder/manage_company_order.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class CompanyEditOrderController {
  TextEditingController estimateId = TextEditingController();
  TextEditingController orderStatus = TextEditingController();
  TextEditingController orderName = TextEditingController();
  TextEditingController orderDescription = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController employeeList = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  Future editOrder(BuildContext context, {required String? signature, required String? employeeId, required String? id}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: "${ApiConstant.companyEditOrder}${id!}/", params: {
      'order_name': orderName.text,
      'order_description': orderDescription.text,
      'change_description': changeDescription.text,
      'amount': amount.text,
      'start_date': startDate.text,
      'due_date': dueDate.text,
      'orderstatus': orderStatus.text,
      'sig-dataUrl': signature!,
      'estimate_id': estimateId.text,
      'employeelist': employeeId!,
      'sign_name': 'company_sign',
    });
    debugPrint("editOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanyOrder()));
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

  Future getEstimateOrderListForCompany(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyEstimateForOrder);
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
