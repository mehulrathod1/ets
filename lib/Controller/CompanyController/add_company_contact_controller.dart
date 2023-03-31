import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/add_company_contact_model.dart';
import '../../Network/api_constant.dart';

class AddCompanyContactController {
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

  Future<AddCompanyContactModel> addCompanyContact(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.addCompanyContacts,
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
    var res = AddCompanyContactModel.fromJson(response);
    print(res.message);
    return res;
  }
}
