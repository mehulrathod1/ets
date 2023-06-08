import 'package:flutter/cupertino.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanySendMessageController {
  TextEditingController message = TextEditingController();

  Future sendMessage(BuildContext context, String id) async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(child: CircularProgressIndicator());
    //     });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companySendMessage,
        params: {'message': message.text, 'employee_id': id});
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
