import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/Colors.dart';
import '../ManageConstruction/add_estimate.dart';
import '../ManageOrder/add_order.dart';
import 'add_event.dart';

class ManageSchedule extends StatefulWidget {
  const ManageSchedule({Key? key}) : super(key: key);

  @override
  State<ManageSchedule> createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDate) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Manage Schedule",
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
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  availableGestures: AvailableGestures.all,
                  onDaySelected: _onDaySelected,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScreenBg),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '23 Feb 2023',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Test Estimate Section - 07:00 AM - 08:30 AM',
                            style:
                                TextStyle(fontSize: 14, color: appThemeGreen),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Test Estimate Section - 07:00 AM - 08:30 AM',
                            style: TextStyle(fontSize: 14, color: appThemeBlue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEvent()));
                            },
                            child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appThemeGreen,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    'ADD EVENT',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddOrder()));
                            },
                            child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appThemeBlue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    'ADD CHANGE ORDER',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEstimate()));
                            },
                            child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appThemeBlack,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    'ADD CONSTRUCTION ESTIMATE',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
