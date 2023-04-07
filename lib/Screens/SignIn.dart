// ignore_for_file: file_names

import 'package:etsemployee/Controller/EmployeeController/employee_login_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool termsandcond = false;
  bool passenable = true;
  EmployeeLoginController employeeLoginController = EmployeeLoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Sign in",
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
                const Text(
                  "Welcome back to Employee Login!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: employeeLoginController.userName,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter UserName',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: employeeLoginController.password,
                    maxLines: 1,
                    obscureText: passenable,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (passenable) {
                              //if passenable == true, make it false
                              passenable = false;
                            } else {
                              passenable = true; //if passenable == false, make it true
                            }
                          });
                        },
                        child: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            passenable == true ? Icons.remove_red_eye : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hintText: 'Enter Password',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                        value: termsandcond,
                        fillColor: MaterialStateProperty.all(colorText),
                        onChanged: (v) {
                          setState(() {
                            termsandcond = v!;
                          });
                        }),
                    const Expanded(
                        child: Text(
                      'Remember Me',
                      style: TextStyle(fontSize: 16),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text('Forgot Password ?', style: TextStyle(fontSize: 16, color: colorred)),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (employeeLoginController.userName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Username required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (employeeLoginController.password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Password required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        employeeLoginController.employeeLogin(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Sign In ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'By clicking sign in above, you agree to ETSs ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(recognizer: TapGestureRecognizer()..onTap = () => debugPrint("object"), text: 'Terms & Conditions', style: TextStyle(color: appThemeGreen)),
                          const TextSpan(text: ' and ', style: TextStyle(color: Colors.black)),
                          TextSpan(recognizer: TapGestureRecognizer()..onTap = () => debugPrint("object"), text: 'Privacy Policy. ', style: TextStyle(color: appThemeGreen)),
                        ]),
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
