import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../utils/Colors.dart';

class AgencyManagement extends StatefulWidget {
  const AgencyManagement({Key? key}) : super(key: key);

  @override
  State<AgencyManagement> createState() => _AgencyManagementState();
}

class _AgencyManagementState extends State<AgencyManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: colorLightGray),
          child:
              Center(child: Text('You are already register with test saless')),
        ),
      ),
    );
  }
}
