// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
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

  Future updateProfileDetails(BuildContext context, {required File companyProfilePic}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.companyUpdateProfile, params: {
      'company_name': companyName.text,
      'contact_person': contactPerson.text,
      'email': email.text,
      'username': name.text,
      'phone': phone.text,
      'address': address.text,
      'city': city.text,
      'state': state.text,
      'zip': zipCode.text,
      'creditcard_no': creditCardNo.text,
      'creditcard_name': creditCardName.text,
      'creditcard_exp_date': creditCardExp.text,
      'security_code': securityCode.text,
      'logo': 'data:image/png;base64,${base64Encode(companyProfilePic.readAsBytesSync())}',
    });
    debugPrint("editProfileDetails response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
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
}
