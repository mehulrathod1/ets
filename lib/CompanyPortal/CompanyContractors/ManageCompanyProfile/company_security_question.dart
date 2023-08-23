import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';

import '../../../utils/Colors.dart';

class CompanySecurityQuestion extends StatefulWidget {
  CompanySecurityQuestion({required this.profilePicture, Key? key})
      : super(key: key);
  String? profilePicture;

  @override
  State<CompanySecurityQuestion> createState() =>
      _CompanySecurityQuestionState();
}

class _CompanySecurityQuestionState extends State<CompanySecurityQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Security Question",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: widget.profilePicture!.isEmpty
                ? const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/etslogo.png'),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.profilePicture!),
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: GestureDetector(
                    onTap: () async {},
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
