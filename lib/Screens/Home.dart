// ignore_for_file: file_names, must_be_immutable

import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'Contractors/ManageProfile/profile_screen.dart';

class Home extends StatefulWidget {
  Home({this.changeScreen, Key? key}) : super(key: key);
  Function(int)? changeScreen;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 130,
                    width: 160,
                    decoration: BoxDecoration(
                      color: colorGreenLight,
                      border: Border.all(color: colorGreen, width: 1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ImageIcon(
                          AssetImage("assets/noun_location.png"),
                          size: 60,
                        ),
                        SizedBox(height: 8),
                        Text("Live Location")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.changeScreen!(1);
                  },
                  child: Container(
                    height: 130,
                    width: 160,
                    decoration: BoxDecoration(
                      color: colorBlueLight,
                      border: Border.all(color: colorBlue, width: 1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ImageIcon(
                          AssetImage("assets/noun_history_.png"),
                          size: 60,
                        ),
                        SizedBox(height: 8),
                        Text("History")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                  },
                  child: Container(
                    height: 130,
                    width: 160,
                    decoration: BoxDecoration(
                      color: colorPinkLight,
                      border: Border.all(color: colorPink, width: 1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ImageIcon(
                          AssetImage("assets/profile.png"),
                          size: 60,
                        ),
                        SizedBox(height: 8),
                        Text("My Profile")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 130,
                  width: 160,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
