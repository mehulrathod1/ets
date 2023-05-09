import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

import '../../Controller/CompanyController/company_notification_controller.dart';
import '../../Models/CompanyModels/company_notification_model.dart';

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
        notificationModel = value;
        notificationList = notificationModel.data.list;
        debugPrint(notificationModel.message);
        loading = false;
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
                                      padding:
                                          EdgeInsets.only(left: 8.0, top: 8),
                                      child: Text(
                                        data.notificationMsg,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        data.date.toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                            fontSize: 12, color: appThemeBlue),
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
