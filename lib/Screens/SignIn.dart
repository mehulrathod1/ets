import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Controller/EmployeeController/employee_login_controller.dart';
import '../Models/CompanyModels/company_login_model.dart';
import '../Models/EmployeeModel/employee_login_model.dart';
import '../utils/Colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool termsandcond = false;
  bool passenable = true; //boolean value to track password view enable disable.

  late EmployeeLoginModel employeeLoginModel;
  EmployeeLoginController employeeLoginController = EmployeeLoginController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: Container(
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage('assets/etslogo.png'),
                          ))),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Welcome back to Employee Login!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          controller: employeeLoginController.userName,
                          style: TextStyle(height: 1.7, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter UserName',
                            fillColor: colorTextField,
                            filled: true,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextFormField(
                          controller: employeeLoginController.password,
                          maxLines: 1,
                          obscureText: passenable,
                          style: TextStyle(height: 1.7, color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (passenable) {
                                    //if passenable == true, make it false
                                    passenable = false;
                                  } else {
                                    passenable =
                                        true; //if passenable == false, make it true
                                  }
                                });
                              },
                              child: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(
                                  passenable == true
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            hintText: 'Enter Password',
                            fillColor: colorTextField,
                            filled: true,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
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
                        Expanded(
                            child: Text(
                          'Remember Me',
                          style: TextStyle(fontSize: 16),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text('Forgot Password ?',
                              style: TextStyle(fontSize: 16, color: colorred)),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeDashboard()));
                        },
                        child: GestureDetector(
                          onTap: () {
                            employeeLoginController
                                .employeeLogin(context)
                                .then((value) {
                              employeeLoginModel = value;
                              print(employeeLoginModel.message);
                            });
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  'Sign In ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:
                                'By clicking sign in above, you agree to ETSs ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => print("object"),
                                  text: 'Terms & Conditions',
                                  style: TextStyle(color: appThemeGreen)),
                              TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => print("object"),
                                  text: 'Privacy Policy. ',
                                  style: TextStyle(color: appThemeGreen)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
