// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_login_screen.dart';
import 'package:flutter/material.dart';

class AgencyRegisterController {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController role = TextEditingController();

  Future agencyRegister(BuildContext context, String logo) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    var request = http.MultipartRequest('POST', Uri.parse(ApiConstant.baseUrl + ApiConstant.agencyRegister));
    request.headers.addAll({"Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"});
    request.fields['name'] = name.text;
    request.fields['address'] = address.text;
    request.fields['city'] = city.text;
    request.fields['state'] = state.text;
    request.fields['zip'] = zip.text;
    request.fields['email'] = email.text;
    request.fields['phone'] = phone.text;
    request.fields['role'] = role.text;
    request.files.add(
      http.MultipartFile(
        'profile_img',
        File(logo).readAsBytes().asStream(),
        File(logo).lengthSync(),
        filename: logo.split("/").last,
      ),
    );
    var response = await request.send();
    debugPrint("agencyRegister response :- ${response.statusCode}");
    debugPrint("agencyRegister response :- ${response.stream}");
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context, MaterialPageRoute(builder: (context) => const SalesLoginScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Agency register successfully."),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops!, Agency registration failed."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
