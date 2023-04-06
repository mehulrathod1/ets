import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'MaangeCompanyTask/manage_task.dart';
import 'ManageCompanyContact/manage_company_contact.dart';
import 'ManageCompanyEstimetes/company_estimeates.dart';
import 'ManageCompanyInvoice/manage_company_invoice.dart';
import 'ManageCompanyNotes/manage_company_note.dart';
import 'ManageCompanyOrder/manage_company_order.dart';
import 'ManageCompanySchedule/manage_schedule.dart';

class CompanyContractorsScreen extends StatefulWidget {
  const CompanyContractorsScreen({Key? key}) : super(key: key);

  @override
  State<CompanyContractorsScreen> createState() => _CompanyContractorsScreenState();
}

class _CompanyContractorsScreenState extends State<CompanyContractorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanyContact()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanyInvoice()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanyOrder()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyEstimate()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanyTask()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanyNote()));
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
                            children: const [ImageIcon(AssetImage("assets/notes.png"), size: 60), SizedBox(height: 8), Text("Notes")],
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCompanySchedule()));
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
