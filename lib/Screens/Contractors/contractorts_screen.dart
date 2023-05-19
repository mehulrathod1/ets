// ignore_for_file: must_be_immutable

import 'package:etsemployee/Screens/Contractors/ManageConstruction/manage_constroction.dart';
import 'package:etsemployee/Screens/Contractors/ManageContacts/manage_contacts.dart';
import 'package:etsemployee/Screens/Contractors/ManageInvoice/manage_invoice.dart';
import 'package:etsemployee/Screens/Contractors/ManageOrder/manage_order.dart';
import 'package:etsemployee/Screens/Contractors/ManageSchedule/manage_schedule.dart';
import 'package:etsemployee/Screens/Contractors/ManageTask/manage_task.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'ManageNotes/manage_notes.dart';

class ContractorsScreen extends StatefulWidget {
  ContractorsScreen({Key? key, this.profilePic}) : super(key: key);
  String? profilePic;

  @override
  State<ContractorsScreen> createState() => _ContractorsScreenState();
}

class _ContractorsScreenState extends State<ContractorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageContactScreen(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorGreenLight,
                            border: Border.all(color: colorGreen, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/contact.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Contacts")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageInvoice(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorBlueBoxLight,
                            border: Border.all(color: colorBoxBlue, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/invoice.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Invoices")
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageOrder(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorPinkLight,
                            border: Border.all(color: colorPink, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/order.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Work/Change Orders")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageConstruction(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorBlueLight,
                            border: Border.all(color: colorBlue, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/construction.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Construction Estimates")
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageTask(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorGreenLight,
                            border: Border.all(color: colorGreen, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/task.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Task")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageNote(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorBlueBoxLight,
                            border: Border.all(color: colorBoxBlue, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/notes.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Notes")
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ManageSchedule(profilePic: widget.profilePic)));
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: colorPinkLight,
                            border: Border.all(color: colorPink, width: 1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage("assets/clock.png"),
                                size: 60,
                              ),
                              SizedBox(height: 8),
                              Text("Schedules")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
