// ignore_for_file: must_be_immutable

import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class MyDrawerHeader extends StatefulWidget {
  MyDrawerHeader({this.userName, this.email, this.profilePicture, Key? key}) : super(key: key);
  String? userName;
  String? email;
  String? profilePicture;

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 8),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/desktop_logo.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
          child: Row(
            children: [
              widget.profilePicture!.isEmpty
                  ? const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/etslogo.png'),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.profilePicture!),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.userName!.isEmpty ? 'Username' : widget.userName!, textAlign: TextAlign.left, style: const TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.email!.isEmpty ? 'crazycoder09@gmail.com' : widget.email!, textAlign: TextAlign.left, style: TextStyle(color: appThemeGreen, fontSize: 10)),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
