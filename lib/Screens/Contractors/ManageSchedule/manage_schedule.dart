// ignore_for_file: must_be_immutable

import 'package:etsemployee/Screens/Contractors/ManageConstruction/add_estimate.dart';
import 'package:etsemployee/Screens/Contractors/ManageOrder/add_order.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Controller/EmployeeController/employee_event_controller.dart';
import '../../../Models/EmployeeModel/employee_event_model.dart';
import 'add_event.dart';

class ManageSchedule extends StatefulWidget {
  ManageSchedule({Key? key, this.profilePic}) : super(key: key);
  String? profilePic;

  @override
  State<ManageSchedule> createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  DateTime today = DateTime.now();
  EmployeeEventController eventController = EmployeeEventController();
  late EmployeeGetEventModel getEventModel;
  List<ListElement> eventList = [];
  bool loading = false;
  List<DateTime> eventDateList = [];

  Map<DateTime, List<dynamic>> events = {};

  List<dynamic> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime day, DateTime focusedDate) {
    setState(() {
      today = day;
    });
  }

  Future initialize(BuildContext context) async {
    setState(() {
      loading = true;
    });
    //s
    await eventController.getEmployeeEvent(context).then((value) {
      setState(() {
        if (value != null) {
          getEventModel = value;
          eventList = getEventModel.data.list;
          eventDateList.clear();
          events.clear();

          for (int i = 0; i < eventList.length; i++) {
            DateTime startDate =
                DateFormat('yyyy-MM-dd').parse(eventList[i].startDate);
            if (events.containsKey(startDate)) {
              events[startDate]!.add(eventList[i]);
            } else {
              events[startDate] = [eventList[i]];
            }
            eventDateList.add(startDate);
          }
          loading = false;
          print(getEventModel.message);
          print(events);
        } else {
          eventList.clear();
          eventDateList.clear();
          events.clear();
          loading = false;
        }
      });
    });
  }

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Manage Schedule",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: widget.profilePic!.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(widget.profilePic!),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2000, 3, 14),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                // selectedDayPredicate: (day) => isSameDay(day, today) && events.containsKey(day),
                selectedDayPredicate: (day) =>
                    isSameDay(day, today) && (_getEventsForDay(day).isNotEmpty),

                availableGestures: AvailableGestures.all,
                onDaySelected: _onDaySelected,
                eventLoader: (day) => _getEventsForDay(day),
              ),
            ),
            Text(
              DateFormat('dd MMM yyyy').format(today), // Display selected date
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._getEventsForDay(today).map((event) => Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    event
                        .eventTitle, // Replace with the appropriate event property
                    style: TextStyle(fontSize: 14, color: appThemeGreen),
                  ),
                )),
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
                      const Text(
                        '23 Feb 2023',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Test Estimate Section - 07:00 AM - 08:30 AM',
                          style: TextStyle(fontSize: 14, color: appThemeGreen),
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
                                    builder: (context) => const AddEvent()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeGreen,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Text(
                                'ADD EVENT',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddOrder(schedule: true)));
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeBlue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
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
                                    builder: (context) => const AddEstimate()));
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeBlack,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
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
    );
  }
}
