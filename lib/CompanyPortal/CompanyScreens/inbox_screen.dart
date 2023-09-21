import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Controller/CompanyController/company_inboc_controller.dart';
import '../../Models/CompanyModels/company_inbox_model.dart';
import '../../Network/api_constant.dart';
import 'company_message_dashboard.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({required this.appBar, Key? key}) : super(key: key);
  bool appBar;

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  CompanyInboxController inboxController = CompanyInboxController();
  bool loading = false;
  late CompanyInboxModel companyInboxModel;
  List<Datum> notificationList = [];

  Future initialize1(BuildContext context) async {
    loading = true;
    await inboxController.getCompanyInbox1(context).then((value) {
      setState(() {
        if (value != null) {
          companyInboxModel = value;
          notificationList = companyInboxModel.data;
          debugPrint(companyInboxModel.message);
          loading = false;
        } else {
          notificationList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message not found'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  Future initialize(BuildContext context,String search) async {
    loading = true;
    await inboxController.getCompanyInbox(context,search: search).then((value) {
      setState(() {
        if (value != null) {
          companyInboxModel = value;
          notificationList = companyInboxModel.data;
          debugPrint(companyInboxModel.message);
          loading = false;
        } else {
          notificationList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message not found'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize1(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar
          ? AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Center(
                child: Text("Inbox",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: ApiConstant.profileImage.isEmpty
                      ? const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        )
                      : CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(ApiConstant.profileImage),
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
            )
          : null,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 8, right: 8, bottom: 16),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
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
                    onSubmitted: (value) {
                      initialize(context, value);
                    },
                    onChanged: (value) {
                      initialize(context, value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      var data = notificationList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 28,
                                      backgroundImage:
                                          AssetImage('assets/man.jpeg'),
                                    ),
                                    const SizedBox(width: 8,),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            data.employeeName,
                                            style: const TextStyle(
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
                                            data.email,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                              CompanyMessageDashboard(
                                                  employeeId: data.id),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "View Message",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: appThemeBlue),
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
              ),
            ],
          ),
    );
  }
}



/*loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
              Container(
                height: 530,
               // color: Colors.red,
                child: ListView.builder(
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
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
                                              CompanyMessageDashboard(
                                                  employeeId: data.id),
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
              ),
            ],
          ),*/
