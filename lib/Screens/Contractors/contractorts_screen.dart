import 'package:etsemployee/Screens/Contractors/ManageConstruction/manage_constroction.dart';
import 'package:etsemployee/Screens/Contractors/ManageContacts/manage_contacts.dart';
import 'package:etsemployee/Screens/Contractors/ManageInvoice/manage_invoice.dart';
import 'package:etsemployee/Screens/Contractors/ManageOrder/manage_order.dart';
import 'package:etsemployee/Screens/Contractors/ManageSchedule/manage_schedule.dart';
import 'package:etsemployee/Screens/Contractors/ManageTask/manage_task.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'ManageNotes/manage_notes.dart';

class ContractorsScreen extends StatefulWidget {
  const ContractorsScreen({Key? key}) : super(key: key);

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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageContactScreen()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/contact.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageInvoice()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/invoice.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageOrder()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/order.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageConstruction()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/construction.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageTask()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/task.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageNote()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/notes.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageSchedule()));
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
                            children: [
                              // Image.asset('assets/noun-history.png'),
                              ImageIcon(
                                AssetImage("assets/clock.png"),
                                size: 60,
                              ),
                              // Icon(
                              //   Icons.location_on_outlined,
                              //   size: 60,
                              // ),
                              SizedBox(height: 8),
                              Text("Schedules")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
