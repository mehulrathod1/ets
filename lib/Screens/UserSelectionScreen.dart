// ignore_for_file: file_names

import 'package:etsemployee/CompanyPortal/CompanyScreens/company_login_screen.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_login_screen.dart';
import 'package:etsemployee/Screens/SignIn.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreen();
}

class _UserSelectionScreen extends State<UserSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/etslogo.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                    child: const Center(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyLoginScreen()));
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: appThemeBlack, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Sign In as Company',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SalesLoginScreen()));
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Sign In Sales Portal',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
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
    );
  }
}
