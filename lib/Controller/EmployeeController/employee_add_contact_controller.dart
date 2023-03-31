import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/company_add_contcat_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class EmployeeAddContactController {
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

  Future<EmployeeAddContactModel> addContact(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeAddContact,
        params: {
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

    var res = EmployeeAddContactModel.fromJson(response);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      duration: Duration(seconds: 2),
    ));

    print(res.message);
    return res;
  }
}
