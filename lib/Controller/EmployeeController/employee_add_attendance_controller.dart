// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/Contractors/ManageProfile/profile_screen.dart';
import '../../Screens/HomeDashboard.dart';

class EmployeeAddAttendanceController {
  Future<bool> addAttendanceHistory({
    required BuildContext context,
    required String address,
    required String profileImage,
    required String status,
    required Placemark place,
    required String timeZon,
    required String time,
  }) async {
    print("==========================+${profileImage}");
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await postDataWithHeader(
        paramUri: ApiConstant.employeeAddAttendance,
        params: {
          "img1": "data:image/jpeg;base64,$profileImage",
          "attendance_call_value": status,
          "address1": place.name,
          "address2": place.name,
          "city": place.locality,
          "state": place.administrativeArea,
          "zipcode": place.postalCode,
          "country": place.country,
          "formatted_address": address,
          "location": address,
          "time_zone": timeZon,
          "current_time": time
        });
    if (response["status"] == "true") {
      Navigator.of(context).pop();

      // ApiConstant.isAttendance = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String status = prefs.get('attendanceStatus').toString();

      if (status == '1') {
        await prefs.remove('attendanceStatus');
        await prefs.setString("attendanceStatus", '1');
      } else if (status == '2') {
        await prefs.remove('attendanceStatus');
        await prefs.setString("attendanceStatus", '2');
      } else {
        await prefs.remove('attendanceStatus');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeDashboard(
                    currentTableSelected: 0,
                  )));
      return true;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String status = prefs.get('attendanceStatus').toString();
      if (status == '1') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("attendanceStatus", '2');
        print('${prefs}two');
      } else if (status == '2') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("attendanceStatus", '1');
        print('${prefs}one');
      } else {
        await prefs.remove('attendanceStatus');
      }

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      if (response["message"] == 'please set the profile picture.') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        );
      }
      return false;
    }
  }
}
