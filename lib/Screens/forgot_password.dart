import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../Controller/EmployeeController/employee_forgot_password_controller.dart';
import '../utils/Colors.dart';
import 'forgot_username.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  EmployeeForgotPasswordController employeeForgotPasswordController =
      EmployeeForgotPasswordController();

  bool _isValidEmail(String email) {
    final gmailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$');
    return gmailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Password Reset",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: colorScreenBg,
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/etslogo.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Password Reset",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: employeeForgotPasswordController.userName,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: colorTextField,
                        suffixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: ImageIcon(
                            const AssetImage('assets/profile1.png'),
                            color: appThemeGreen,
                          ),
                        ),
                        hintText: 'Please Enter Username',
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGray, width: 1.0),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: employeeForgotPasswordController.email,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: colorTextField,
                        suffixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: ImageIcon(
                            const AssetImage('assets/message.png'),
                            color: appThemeGreen,
                          ),
                        ),
                        hintText: 'Please Enter Email',
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGray, width: 1.0),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (employeeForgotPasswordController
                          .userName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Username required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (employeeForgotPasswordController
                          .email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Email required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (!_isValidEmail(
                          employeeForgotPasswordController.email.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Invalid Email format!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        employeeForgotPasswordController
                            .employeeForgotPassword(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: appThemeGreen,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotUsername()));
                  },
                  child: Text(
                    "Forgot Username",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: appThemeGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
