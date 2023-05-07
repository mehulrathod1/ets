// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setAttendanceValue(String? value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("attendanceStatus", value!);
}

Future AttendancePopUP(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                        width: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Status',
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            'assets/close.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Text(
                  'Please select your Attendance status',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    await setAttendanceValue("1");
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'IN',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    await setAttendanceValue("2");
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: appThemeBlack, borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'CALL FOR ATTENDANCE',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    await setAttendanceValue("3");
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'STOP SHARING LOCATION',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      });
}
