// ignore_for_file: must_be_immutable

import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class MyDrawerHeader extends StatefulWidget {
  MyDrawerHeader({this.userName, this.email, this.profilePicture, Key? key}) : super(key: key);
  String? userName;
  String? email;
  String? profilePicture;

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(
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
                    companyProfileModel.data.companyLogo.isEmpty
                        ? const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/man.jpeg'),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                companyProfileModel.data.companyLogo),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(companyProfileModel.data.companyName,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(companyProfileModel.data.email,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: appThemeGreen, fontSize: 10)),
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
