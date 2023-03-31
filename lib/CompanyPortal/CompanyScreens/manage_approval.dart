import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/Colors.dart';

class ManageApproval extends StatefulWidget {
  const ManageApproval({Key? key}) : super(key: key);

  @override
  State<ManageApproval> createState() => _ManageApprovalState();
}

class _ManageApprovalState extends State<ManageApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
                              child: Text(
                                "test267 Sents You Changing Profile ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Text(
                                "Jan 17,2023 05:54 AM",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
                              child: Text(
                                "Approved",
                                style: TextStyle(
                                    fontSize: 12, color: appThemeBlue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: const DecoratedBox(
                          decoration: const BoxDecoration(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
