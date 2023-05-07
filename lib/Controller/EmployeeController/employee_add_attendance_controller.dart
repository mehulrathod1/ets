// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class EmployeeAddAttendanceController {
  Future<bool> addAttendanceHistory({required BuildContext context, required String address, required String profileImage, required String status, required Placemark place}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(paramUri: ApiConstant.employeeAddAttendance, params: {"img1": "data:image/jpeg;base64,$profileImage", "attendance_call_value": status, "address1": place.name, "address2": place.name, "city": place.locality, "state": place.administrativeArea, "zipcode": place.postalCode, "country": place.country, "formatted_address": address, "location": address, "time_zone": ""});
    if (response["status"] == "True") {
      return true;
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    }
  }
}
