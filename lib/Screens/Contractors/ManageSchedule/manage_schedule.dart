// ignore_for_file: must_be_immutable

import 'package:etsemployee/Screens/Contractors/ManageConstruction/add_estimate.dart';
import 'package:etsemployee/Screens/Contractors/ManageOrder/add_order.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Controller/EmployeeController/employee_event_controller.dart';
import '../../../Controller/EmployeeController/employee_order_controller.dart';
import '../../../Models/EmployeeModel/employee_event_model.dart';
import '../../../Models/EmployeeModel/employee_order_model.dart';
import 'add_event.dart';

class ManageSchedule extends StatefulWidget {
  ManageSchedule({Key? key, this.profilePic}) : super(key: key);
  String? profilePic;

  @override
  State<ManageSchedule> createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  DateTime _selectedDate = DateTime.now();
  EmployeeEventController eventController = EmployeeEventController();
  late EmployeeGetEventModel getEventModel;
  List<ListElement1> eventList = [];
  bool loading = false;
  String showDate = '';

  late EmployeeOrderModel employeeOrderModel;
  List<ListElement> orderList = [];
  EmployeeOrderController employeeOrderController = EmployeeOrderController();

  Future getOrderList(BuildContext context, String search) async {
    await employeeOrderController
        .getEmployeeContact(context, search: search, page: 1)
        .then((value) {
      setState(() {
        if (value != null) {
          employeeOrderModel = value;
          orderList = employeeOrderModel.data.list;
          print(orderList.length);
        } else {
          orderList.clear();
        }
      });
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      showDate = DateFormat('dd MMM yyyy').format(_selectedDate);
      print(showDate);
    });
  }

  Future initialize(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await eventController.getEmployeeEvent(context).then((value) {
      setState(() {
        if (value != null) {
          getEventModel = value;
          eventList = getEventModel.data.list;
          loading = false;
          print(getEventModel.message);
        } else {
          eventList.clear();
          loading = false;
        }
      });
    });
  }

  bool isEventOnSelectedDate(DateTime startDate) {
    return isSameDay(startDate, _selectedDate);
  }

  bool isEventOnDate(DateTime date) {
    return eventList.any((event) =>
        isSameDay(DateFormat('yyyy-MM-dd').parse(event.startDate), date));
  }

  @override
  void initState() {
    getOrderList(context, '');
    initialize(context);
    super.initState();
  }

  void refreshData() {
    setState(() {
      getOrderList(context, '');
      initialize(context);
    });
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
          child: Text(
            "Manage Schedule",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
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
              child: EventCalendar(
                selectedDate: _selectedDate,
                onDaySelected: _onDaySelected,
                eventList: eventList,
                orderList: orderList,
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
                        showDate,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: eventList.length +
                            orderList
                                .length, // Use the combined length of eventList and orderList
                        itemBuilder: (context, index) {
                          if (index < eventList.length) {
                            // Render event data
                            final event = eventList[index];
                            final startDate =
                                DateFormat('yyyy-MM-dd').parse(event.startDate);

                            if (isEventOnSelectedDate(startDate)) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${event.eventName} : ${event.startDate} To ${event.dueDate}',
                                  style: TextStyle(
                                      fontSize: 14, color: appThemeGreen),
                                ),
                              );
                            }
                          } else {
                            // Render order data
                            final orderIndex = index - eventList.length;
                            if (orderIndex < orderList.length) {
                              final order = orderList[orderIndex];
                              final startDate = DateFormat('yyyy-MM-dd')
                                  .parse(order.startDate.toString());

                              if (isEventOnSelectedDate(startDate)) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '${order.orderName} : ${order.startDate} To ${order.dueDate}',
                                    style: TextStyle(
                                        fontSize: 14, color: appThemeBlue),
                                  ),
                                );
                              }
                            }
                          }
                          return Container();
                        },
                      ),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddEvent(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'ADD EVENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddOrder(
                                schedule: true,
                                callback: () {
                                  refreshData();
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: appThemeBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'ADD CHANGE ORDER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEstimate(
                                callback: () {
                                  refreshData();
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: appThemeBlack,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'ADD CONSTRUCTION ESTIMATE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
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

class EventCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime, DateTime) onDaySelected;
  final List<ListElement1> eventList;
  final List<ListElement> orderList;

  EventCalendar({
    required this.selectedDate,
    required this.onDaySelected,
    required this.eventList,
    required this.orderList,
  });

  bool isEventOnDate(DateTime date) {
    return eventList.any((event) =>
            isSameDay(DateFormat('yyyy-MM-dd').parse(event.startDate), date)) ||
        orderList.any((order) =>
            isSameDay(DateFormat('yyyy-MM-dd').parse(order.startDate), date));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 3, 14),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: selectedDate,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      availableGestures: AvailableGestures.all,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (isEventOnDate(date)) {
            return Positioned(
              bottom: 0,
              child: Icon(
                Icons.circle,
                color: appThemeGreen,
                size: 4,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      selectedDayPredicate: (day) {
        return isSameDay(day, selectedDate);
      },
      onDaySelected: onDaySelected,
    );
  }
}
