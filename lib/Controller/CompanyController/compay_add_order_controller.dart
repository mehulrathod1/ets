import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_add_order_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyAddOrderController {
  CompanyAddOrderModel? addOrderModel;
  TextEditingController estimateId = TextEditingController();
  TextEditingController orderStatus = TextEditingController();
  TextEditingController orderName = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController orderDescription = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  Future addOrder(BuildContext context, {required String? signature}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddOrder,
        params: {
          'order_name': orderName.text,
          'order_description': orderDescription.text,
          'change_description': changeDescription.text,
          'amount': amount.text,
          'start_date': startDate.text,
          'due_date': dueDate.text,
          'orderstatus': orderStatus.text,
          'sig-dataUrl': signature!,
          'estimate_id': estimateId.text,
          'employeelist': '',
          'sign_name': '',
        });
    debugPrint("addOrder response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddOrderModel.fromJson(response);
      addOrderModel = res;
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

  Future getEstimateOrderListForCompany(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyEstimateForOrder);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
