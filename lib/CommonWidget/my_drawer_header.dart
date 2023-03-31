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
    return Container(
      child: Column(
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
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/etslogo.png'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
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
          ),
          SizedBox(height: 10),
          Divider(
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
