import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../utils/Colors.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({Key? key}) : super(key: key);

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Edit Employee",
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: colorScreenBg,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Employee Email",
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
                            hintText: 'crazycoder08@gmail.com',
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
                              borderSide:
                                  BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Employee Name",
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
                            hintText: 'Kate Thomas test',
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
                              borderSide:
                                  BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Password",
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
                            hintText: '********',
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
                              borderSide:
                                  BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          'Company',
                          style: TextStyle(height: 1.7, fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'test11',
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
                              borderSide:
                                  BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Department",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                              widthFactor: 1,
                              heightFactor: 1,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: appThemeGreen,
                              ),
                            ),
                            hintText: 'Account',
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
                              borderSide:
                                  BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeGreen,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
