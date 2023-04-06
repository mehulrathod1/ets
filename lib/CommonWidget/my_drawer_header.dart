import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({Key? key}) : super(key: key);

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
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/etslogo.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Username',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('crazycoder09@gmail.com',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: appThemeGreen, fontSize: 10)),
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
