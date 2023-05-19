// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/CompanyModels/company_add_contcat_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:etsemployee/Screens/Contractors/ManageContacts/manage_contacts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeAddContactController {
  EmployeeAddContactModel? employeeAddContactModel;
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

  Future addContact(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeAddContact, params: {
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
    debugPrint("addContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      var res = EmployeeAddContactModel.fromJson(response);
      employeeAddContactModel = res;
      Navigator.pop(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ManageContactScreen(profilePic: prefs.get("profilePic").toString())));
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

  Future editContact(BuildContext context, {String? id}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeEditContact + id!, params: {
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
    debugPrint("editContact response :- ${response.toString()}");
    if (response["status"] == 'True') {
      Navigator.pop(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ManageContactScreen(profilePic: prefs.get("profilePic").toString())));
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
