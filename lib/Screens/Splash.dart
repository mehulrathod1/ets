// ignore_for_file: file_names

import 'dart:async';
import 'package:etsemployee/CompanyPortal/CompanyScreens/company_dashboard.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_dashboard.dart';
import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:etsemployee/Screens/UserSelectionScreen.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer timer;

  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiConstant.userToken = prefs.get('token').toString();
    debugPrint(ApiConstant.userToken);
    var usertype = prefs.get('userIdentity').toString();

    var status = prefs.get('attendanceStatus').toString();
    // await prefs.remove('attendanceStatus');
    print('aaaaaa --- ${status}');

    if (usertype == 'company') {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CompanyDashboard())));
    } else if (usertype == 'employee') {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeDashboard(
                        currentTableSelected: 0,
                      ))));
    } else if (usertype == 'sales') {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SalesDashboard())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserSelectionScreen())));
    }
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: appThemeGreen),
        child: const Center(
          child: Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/etslogo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
