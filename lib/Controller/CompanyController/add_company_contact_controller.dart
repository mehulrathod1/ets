// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/CompanyModels/add_company_contact_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class AddCompanyContactController {
  AddCompanyContactModel? addCompanyContactModel;
  TextEditingController customerType = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController homeNumber = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  Future addCompanyContact(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.addCompanyContacts, params: {
      'customer_type': customerType.text,
      'first_name': firstName.text,
      'last_name': lastName.text,
      'company_name': companyName.text,
      'address': address.text,
      'city': city.text,
      'state': state.text,
      'zipcode': zipcode.text,
      'email': email.text,
      'home_number': homeNumber.text,
      'mobile_number': mobileNumber.text,
    });
    debugPrint("addCompanyContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = AddCompanyContactModel.fromJson(response);
      addCompanyContactModel = res;
      Navigator.pop(context);
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
