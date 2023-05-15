// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:etsemployee/CompanyPortal/CompanyScreens/company_login_screen.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:flutter/material.dart';

class CompanyRegistrationController {
  TextEditingController companyName = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController creditCardNumber = TextEditingController();
  TextEditingController creditCardName = TextEditingController();
  TextEditingController creditCardExp = TextEditingController();
  TextEditingController securityCode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  Future companyRegister(BuildContext context, String logo) async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    var request = http.MultipartRequest('POST', Uri.parse(ApiConstant.baseUrl + ApiConstant.companyRegister));
    request.headers.addAll({"Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"});
    request.fields['company_name'] = companyName.text;
    request.fields['contact_person'] = contactPerson.text;
    request.fields['address'] = address.text;
    request.fields['city'] = city.text;
    request.fields['state'] = state.text;
    request.fields['zip'] = zip.text;
    request.fields['creditcard_no'] = creditCardNumber.text;
    request.fields['creditcard_name'] = creditCardName.text;
    request.fields['creditcard_exp_date'] = creditCardExp.text;
    request.fields['security_code'] = securityCode.text;
    request.fields['email'] = email.text;
    request.fields['phone'] = phone.text;
    request.files.add(
      http.MultipartFile(
        'logo',
        File(logo).readAsBytes().asStream(),
        File(logo).lengthSync(),
        filename: logo.split("/").last,
      ),
    );
    var response = await request.send();
    debugPrint("companyRegister response :- ${response.statusCode}");
    debugPrint("companyRegister response :- ${response.stream}");
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context, MaterialPageRoute(builder: (context) => const CompanyLoginScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Company register successfully."),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops!, Company registration failed."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
