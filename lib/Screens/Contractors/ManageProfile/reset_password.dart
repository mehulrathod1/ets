import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../utils/Colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("reset Password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
            ),
          ),
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                    child: Text(
                      "Previous Password",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextField(
                      style: TextStyle(
                          height: 1.7, fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter current password',
                        fillColor: colorScreenBg,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                    child: Text(
                      "New Password",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextField(
                      style: TextStyle(
                          height: 1.7, fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter new password',
                        fillColor: colorScreenBg,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextField(
                      style: TextStyle(
                          height: 1.7, fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter Confirm Password',
                        fillColor: colorScreenBg,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
