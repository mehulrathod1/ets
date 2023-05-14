import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/get_employee_live_location.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyEmployeeLiveLocationController {
  GetEmployeeLiveLocation? employeeLiveLocation;
  // Future liveLocation(BuildContext context, String id) async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(child: CircularProgressIndicator());
  //       });
  //   var response =
  //       await getData(paramUri: ApiConstant.companyEmployeeLiveLocation + id);
  //   debugPrint("deleteContact response :- ${response.toString()}");
  //   if (response["status"] == 'True') {
  //     var res = GetEmployeeLiveLocation.fromJson(response);
  //     employeeLiveLocation = res;
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(res.message),
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   } else {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content:
  //             Text(response["employee doesn't start sharing live location"]),
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }
  Future liveLocation(BuildContext context, String id) async {
    var response =
        await getData(paramUri: ApiConstant.companyEmployeeLiveLocation + id);
    if (response["status"] == "True" && response["data"] != null) {
      return GetEmployeeLiveLocation.fromJson(response);
    } else {
      return response["message"];
    }
  }
}
