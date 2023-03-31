import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../utils/Colors.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScreenBg,
        body: Center(
          child: Container(
            child: Text('messages'),
          ),
        ));
  }
}
