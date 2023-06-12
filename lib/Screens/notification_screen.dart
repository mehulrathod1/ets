import 'package:etsemployee/Controller/EmployeeController/employee_notification_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_notification_model.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/profile_screen.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

import 'message_screen.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({
    this.changeScreen,
    Key? key,
  }) : super(key: key);
  Function(int)? changeScreen;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool loading = false;
  EmployeeNotificationController notificationController =
      EmployeeNotificationController();
  late EmployeeNotificationModel notificationModel;
  List<ListElement> notificationList = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await notificationController.getNotification(context).then((value) {
      setState(() {
        notificationModel = value;
        notificationList = notificationModel.data.list;
        loading = false;
        debugPrint(value.message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                              const CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage('assets/man.jpeg'),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: Text(
                                        detail.notificationMsg,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        detail.date.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: InkWell(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCompanyEstimates()));
                                          if (detail.button.button ==
                                              "Change Profile") {
                                            widget.changeScreen!(0);
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>  Profile()));
                                          } else if (detail.button.button ==
                                              "Share location") {
                                            widget.changeScreen!(0);
                                          } else if (detail.button.button ==
                                              "Call For Attendance") {
                                            widget.changeScreen!(0);
                                          } else if (detail.button.button ==
                                              "View Details") {
                                            widget.changeScreen!(0);
                                          } else if (detail.button.button ==
                                              "View Task") {
                                            widget.changeScreen!(0);
                                          } else if (detail.button.button ==
                                              "View Message") {
                                            widget.changeScreen!(0);
                                          }
                                        },
                                        child: Text(
                                          detail.button.button,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: appThemeBlue),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.black),
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
