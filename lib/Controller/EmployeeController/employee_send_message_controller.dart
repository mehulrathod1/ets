import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeSendMessageController {
  TextEditingController message = TextEditingController();

  Future sendMessage(BuildContext context) async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(child: CircularProgressIndicator());
    //     });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeSendMessage,
        params: {
          'message': message.text,
        });
    debugPrint("addEvent response :- ${response.toString()}");
    // if (response["status"] == 'True') {
    //   // Navigator.pop(context);
    //
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   SnackBar(
    //   //     content: Text(response["message"]),
    //   //     duration: const Duration(seconds: 2),
    //   //   ),
    //   // );
    // } else {
    // Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(response["message"]),
    //     duration: const Duration(seconds: 2),
    //   ),
    // );
    // }
  }
}
