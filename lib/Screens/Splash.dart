import 'dart:async';

import 'package:etsemployee/CompanyPortal/CompanyScreens/company_dashboard.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_dashboard.dart';
import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:etsemployee/Screens/UserSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CompanyPortal/CompanyScreens/company_login_screen.dart';
import '../utils/Colors.dart';

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
    print(ApiConstant.userToken);
    var usertype = prefs.get('userIdentity').toString();

    if (usertype == 'company') {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CompanyDashboard())));
    } else if (usertype == 'employee') {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeDashboard())));
    } else if (usertype == 'sales') {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SalesDashboard())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserSelectionScreen())));
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
        child: Center(
          child: Container(
            child: Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/etslogo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
