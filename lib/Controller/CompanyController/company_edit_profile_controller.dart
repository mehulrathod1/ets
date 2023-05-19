// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:etsemployee/CompanyPortal/CompanyScreens/company_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:etsemployee/Network/api_constant.dart';
import 'package:flutter/material.dart';

class CompanyUpdateProfileController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController creditCardName = TextEditingController();
  TextEditingController creditCardNo = TextEditingController();
  TextEditingController creditCardExp = TextEditingController();
  TextEditingController securityCode = TextEditingController();

  Future updateProfileDetails(BuildContext context,
      {required File companyProfilePic}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var request = http.MultipartRequest('POST',
        Uri.parse(ApiConstant.baseUrl + ApiConstant.companyUpdateProfile));
    request.headers.addAll({
      "Content-Type":
          "multipart/form-data; boundary=<calculated when request is sent>",
      'X-Access-Token': ApiConstant.userToken
    });
    request.fields['company_name'] = companyName.text;
    request.fields['contact_person'] = contactPerson.text;
    request.fields['email'] = email.text;
    request.fields['username'] = name.text;
    request.fields['phone'] = phone.text;
    request.fields['address'] = address.text;
    request.fields['city'] = city.text;
    request.fields['state'] = state.text;
    request.fields['zip'] = zipCode.text;
    request.fields['creditcard_no'] = creditCardNo.text;
    request.fields['creditcard_name'] = creditCardName.text;
    request.fields['creditcard_exp_date'] = creditCardExp.text;
    request.fields['security_code'] = securityCode.text;
    request.files.add(
      http.MultipartFile(
        'logo',
        File(companyProfilePic.path).readAsBytes().asStream(),
        File(companyProfilePic.path).lengthSync(),
        filename: companyProfilePic.path.split("/").last,
      ),
    );
    var response = await request.send();
    debugPrint("editProfileDetails response :- ${response.statusCode}");
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CompanyDashboard()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("profile details update successfully"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops! Failed to update profile details."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
