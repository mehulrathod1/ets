import 'package:etsemployee/Screens/SignIn.dart';
import 'package:flutter/material.dart';

import '../CompanyPortal/CompanyScreens/company_dashboard.dart';
import '../CompanyPortal/CompanyScreens/company_login_screen.dart';
import '../SalesPortal/SalesScreen/sales_dashboard.dart';
import '../SalesPortal/SalesScreen/sales_login_screen.dart';
import '../utils/Colors.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreen();
}

class _UserSelectionScreen extends State<UserSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/etslogo.png'),
                      ))),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Sign In as Employee',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyLoginScreen()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeBlack,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Sign In as Company',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesLoginScreen()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeBlue,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Sign In Sales Portal',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        '   Sign Up here',
                        style: TextStyle(color: appThemeGreen, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
