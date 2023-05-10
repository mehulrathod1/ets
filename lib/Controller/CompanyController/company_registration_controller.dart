import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyScreens/company_login_screen.dart';
import '../../Models/CompanyModels/company_registration_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyRegistrationController {
  CompanyRegistrationModel? companyRegistrationModel;

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
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyRegister,
        params: {
          'company_name': companyName.text,
          'contact_person': contactPerson.text,
          'address': address.text,
          'city': city.text,
          'state': state.text,
          'zip': zip.text,
          'creditcard_no': creditCardName.text,
          'creditcard_name': creditCardName.text,
          'creditcard_exp_date': creditCardExp.text,
          'security_code': securityCode.text,
          'email': email.text,
          'phone': phone.text,
          'logo': logo,
          "employee": ''
        });
    if (response["status"] == 'True') {
      var res = CompanyRegistrationModel.fromJson(response);
      companyRegistrationModel = res;
      Navigator.pop(context);
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => const CompanyLoginScreen()));
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
}
