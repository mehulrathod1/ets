import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

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
