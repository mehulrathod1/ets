import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Network/api_constant.dart';

class AgencyManagement extends StatefulWidget {
  AgencyManagement({required this.appBar, Key? key}) : super(key: key);
  bool appBar;

  @override
  State<AgencyManagement> createState() => _AgencyManagementState();
}

class _AgencyManagementState extends State<AgencyManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar
          ? AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Center(
                child: Text("Agent Or Agency",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: ApiConstant.profileImage.isEmpty
                      ? const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        )
                      : CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(ApiConstant.profileImage),
                        ),
                ),
              ],
              leading: Builder(builder: (context) {
                return GestureDetector(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              }),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: colorLightGray),
          child: const Center(
              child: Text('You are already register with test saless')),
        ),
      ),
    );
  }
}
