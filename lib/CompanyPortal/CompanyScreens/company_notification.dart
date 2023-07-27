import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

import '../../Controller/CompanyController/company_notification_controller.dart';
import '../../Models/CompanyModels/company_notification_model.dart';
import 'agency_management.dart';
import 'company_fix_hour_request.dart';
import 'compnay_notification_detail.dart';
import 'employee_management.dart';
import 'inbox_screen.dart';
import 'manage_approval.dart';

class CompanyNotification extends StatefulWidget {
  const CompanyNotification({Key? key}) : super(key: key);

  @override
  State<CompanyNotification> createState() => _CompanyNotificationState();
}

class _CompanyNotificationState extends State<CompanyNotification> {
  bool loading = false;
  CompanyNotificationController notificationController =
      CompanyNotificationController();
  late CompanyNotificationModel notificationModel;
  List<ListElement> notificationList = [];

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await notificationController.getNotification(context).then((value) {
      setState(() {
        if (value != null) {
          notificationModel = value;
          notificationList = notificationModel.data.list;
          print(
              "editOrder response :- ${notificationModel.data.unreadNotification}");

          loading = false;
        } else {
          notificationList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Notification not found'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    var data = notificationList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(data.employeeImg ?? ""),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: Text(
                                        data.notificationMsg,
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
                                        data.date.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (data.button.button ==
                                            'Manage Request') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AgencyManagement(
                                                appBar: true,
                                              ),
                                            ),
                                          );
                                        } else if (data.button.button ==
                                            'Manage Approval') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ManageApproval(
                                                appBar: true,
                                              ),
                                            ),
                                          );
                                        } else if (data.button.button ==
                                            'View Location') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployeeManagement(
                                                appBar: true,
                                              ),
                                            ),
                                          );
                                        } else if (data.button.button ==
                                            'View Call For Attendance') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployeeManagement(
                                                appBar: true,
                                              ),
                                            ),
                                          );
                                        } else if (data.button.button ==
                                            'View Details') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CompanyFixHourRequest(
                                                appBar: true,
                                              ),
                                            ),
                                          );
                                        } else if (data.button.button ==
                                            'View Message') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InboxScreen(
                                                appBar: true,
                                              ),
                                            ),
                                          );
                                        }
                                        // EmployeeManagement
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         CompanyNotificationDetail(),
                                        //   ),
                                        // );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Text(
                                          data.button.button.toString(),
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
