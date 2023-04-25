import 'package:etsemployee/Screens/Contractors/ManageProfile/edit_profile.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/profile_change_request.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/reset_password.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Profile", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
            ),
          ),
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }),
      ),*/
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/man.jpeg'),
                ),
              ),
            ),
          ),
          const Text(
            'Test Edit 1',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'crazycoder09@gmail.com',
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8, bottom: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: Colors.black), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Name: ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Test Edit 1",
                          style: TextStyle(fontSize: 18, color: colorTextGray),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Email: ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "crazycoder09@gmail.com",
                          style: TextStyle(fontSize: 18, color: colorTextGray),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Company Name: ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "test11",
                          style: TextStyle(fontSize: 18, color: colorTextGray),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Department: ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "1",
                          style: TextStyle(fontSize: 18, color: colorTextGray),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
              },
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Edit Info',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
              },
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileChangeRequest()));
              },
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Request Change Profile',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
