import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../Controller/EmployeeController/employee_notification_controller.dart';
import '../Models/EmployeeModel/employee_notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  EmployeeNotificationController notificationController =
      EmployeeNotificationController();
  late EmployeeNotificationModel notificationModel;
  List<ListElement> notificationList = [];

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    notificationController.getNotification(context).then((value) {
      setState(() {
        notificationModel = value;
        notificationList = notificationModel.data.list;
        print(value.message);
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: notificationList.length,
            itemBuilder: (context, index) {
              var detail = notificationList[index];
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
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Text(
                                  detail.notificationMsg,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                ),
                                child: Text(
                                  detail.date.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Text(
                                  "View Task",
                                  style: TextStyle(
                                      fontSize: 12, color: appThemeBlue),
                                ),
                              ),
                            ],
                          ),
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
