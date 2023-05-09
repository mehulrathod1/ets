import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_edit_profile_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

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

  Future updateProfileDetails(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyUpdateProfile,
        params: {
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
          'logo': "",
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
