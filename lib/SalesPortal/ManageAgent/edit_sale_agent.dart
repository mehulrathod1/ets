import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';

import '../../utils/Colors.dart';

class EditSalesAgent extends StatefulWidget {
  const EditSalesAgent({Key? key}) : super(key: key);

  @override
  State<EditSalesAgent> createState() => _EditSalesAgentState();
}

class _EditSalesAgentState extends State<EditSalesAgent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Edit Agent",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
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
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/man.jpeg'),
                    ))),
              ),
              Text(
                'Test Edit 1',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Email",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'crazycoder09@gmail.com',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Password",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: '*******',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Address",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Agent Address',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Phone",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: '9876543210',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "City *",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Enter City',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "State *",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Enter State',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Zip *",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Zip',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20),
                                child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: appThemeGreen,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
