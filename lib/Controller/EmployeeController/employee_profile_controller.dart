// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Models/EmployeeModel/employee_profile_details_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class EmployeeProfileController {
  TextEditingController userName = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController employeeEmail = TextEditingController();

  Future getEmployeeProfile(BuildContext context) async {
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeViewProfileDetails, params: {});
    if (response["status"] == "True" && response["data"] != null) {
      return EmployeeProfileDetailsModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future editProfilePicture(BuildContext context, String imageBytesData) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeUpdateProfilePicture,
        params: {
          'update_profile': "data:image/jpeg;base64,$imageBytesData",
        });
    debugPrint("editProfilePicture response :- ${response.toString()}");
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

  Future editProfileDetails(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeUpdateProfileDetails,
        params: {
          'employee_name': employeeName.text,
          'username': userName.text,
          'email': employeeEmail.text,
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
