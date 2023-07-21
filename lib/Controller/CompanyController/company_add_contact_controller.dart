// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/CompanyPortal/CompanyContractors/ManageCompanyContact/manage_company_contact.dart';
import 'package:etsemployee/Models/CompanyModels/company_add_contact_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class CompanyAddContactController {
  CompanyAddContactModel? addContactModel;

  TextEditingController customerType = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
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
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyAddContact,
        params: {
          'customer_type': customerType.text,
          'first_name': firstName.text,
          'last_name': lastName.text,
          'address': address.text,
          'city': city.text,
          'state': state.text,
          'zipcode': zipcode.text,
          'email': email.text,
          'home_number': homeNumber.text,
          'mobile_number': mobileNumber.text,
        });
    debugPrint("addContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = CompanyAddContactModel.fromJson(response);
      addContactModel = res;
      Navigator.pop(context);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const ManageCompanyContact()));

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

  Future getCustomerTypeForContact(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyCustomerType);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
}
