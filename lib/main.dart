import 'package:flutter/material.dart';

import 'Screens/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffEAEAEA),
          unselectedWidgetColor: Color(0xff231F20)),
      home: Splash(),
    );
  }
}
