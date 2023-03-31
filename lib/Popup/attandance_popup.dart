import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

Future AttendancePopUP(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Container(
              color: Colors.black,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'SELLER ADMIN',
                  style: TextStyle(color: Colors.white),
                ),
              ))),
        );
      });
}
