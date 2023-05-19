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
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffEAEAEA), unselectedWidgetColor: const Color(0xff231F20)),
      home: const Splash(),
    );
  }
}
