import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/Colors.dart';

Future editDepartment(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Edit Department',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                      Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                    child: Text(
                      "Department Name:",
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
                        hintText: 'IT',
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
                    padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                    child: Text(
                      "Company:",
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
                        hintText: 'Test',
                        fillColor: colorLightGray,
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
