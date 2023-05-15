import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

import '../../Controller/CompanyController/company_inboc_controller.dart';
import '../../Models/CompanyModels/company_inbox_model.dart';
import 'company_message_dashboard.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  CompanyInboxController inboxController = CompanyInboxController();
  bool loading = false;
  late CompanyInboxModel companyInboxModel;
  List<Datum> notificationList = [];

  Future initialize(BuildContext context) async {
    loading = true;
    await inboxController.getCompanyInbox(context).then((value) {
      setState(() {
        if (value != null) {
          companyInboxModel = value;
          notificationList = companyInboxModel.data;
          debugPrint(companyInboxModel.message);
          loading = false;
        } else {
          notificationList.clear();
          loading = false;
          print('lododwww');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Inbox not found'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 8, right: 8, bottom: 16),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Icon(
                              Icons.search,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: 'Search',
                          fillColor: colorScreenBg,
                          filled: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 12, top: 6, bottom: 6),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(7)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colorGray, width: 1.0),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage:
                                          AssetImage('assets/man.jpeg'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            data.employeeName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: Text(
                                            data.email,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyMessageDashboard(),
                                          ),
                                        );
                                      },
                                      child: Expanded(
                                        child: Text(
                                          "View Message",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: appThemeBlue),
                                        ),
                                      ),
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
                                    decoration:
                                        BoxDecoration(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
