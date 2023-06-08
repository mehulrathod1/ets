// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

import '../../CompanyPortal/CompanyContractors/ManageCompanyContact/manage_company_contact.dart';

class CompanyEditContactController {
  TextEditingController customerType = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController laseName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController homeNo = TextEditingController();
  TextEditingController mobileNo = TextEditingController();

  Future editContact(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.companyEditContact + id,
        params: {
          'customer_type': customerType.text,
          'first_name': firstName.text,
          'last_name': laseName.text,
          'address': address.text,
          'city': city.text,
          'state': state.text,
          'zipcode': zipCode.text,
          'email': email.text,
          'home_number': homeNo.text,
          'mobile_number': mobileNo.text,
        });
    debugPrint("editNote response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ManageCompanyContact()));
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
