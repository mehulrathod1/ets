import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future viewAddress(BuildContext context, String address) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Location',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 18, right: 18, bottom: 30),
                  child: Text(
                    address,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
