import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/SalesModel/sales_agency_refgister_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';
import '../../SalesPortal/SalesScreen/sales_login_screen.dart';

class AgencyRegisterController {
  AgencyRegisterModel? agencyRegisterModel;

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController role = TextEditingController();

  Future agencyRegister(BuildContext context, String logo) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await postDataWithHeader(paramUri: ApiConstant.agencyRegister, params: {
      'name': name.text,
      'address': address.text,
      'city': city.text,
      'state': state.text,
      'zip': zip.text,
      'email': email.text,
      'phone': phone.text,
      'profile_img': logo,
      'role': role.text,
    });
    if (response["status"] == 'True') {
      var res = AgencyRegisterModel.fromJson(response);
      agencyRegisterModel = res;
      Navigator.pop(context);
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => const SalesLoginScreen()));
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
