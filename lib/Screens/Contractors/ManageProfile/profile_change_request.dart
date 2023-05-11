import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileChangeRequest extends StatefulWidget {
  const ProfileChangeRequest({Key? key}) : super(key: key);

  @override
  State<ProfileChangeRequest> createState() => _ProfileChangeRequestState();
}

class _ProfileChangeRequestState extends State<ProfileChangeRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Profile Request", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
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
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Note",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(border: Border.all(width: 1, color: colorGray), borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter task description',
                        fillColor: colorScreenBg,
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
