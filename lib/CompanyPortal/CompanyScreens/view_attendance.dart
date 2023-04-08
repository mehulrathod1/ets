// ignore_for_file: use_build_context_synchronously

import 'package:etsemployee/CompanyPortal/CompanyScreens/view_attendance_image.dart';
import 'package:etsemployee/CompanyPortal/CompanyScreens/view_attendance_location.dart';
import 'package:etsemployee/CompanyPortal/PopUps/address_popup.dart';
import 'package:etsemployee/Controller/CompanyController/company_attendance_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_hour_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_hour_model.dart';
import 'package:etsemployee/Models/CompanyModels/company_view_arttendance_model.dart';
import 'package:etsemployee/Popup/view_hour_popup.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_attendance_list.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({Key? key}) : super(key: key);

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  bool loading = false;
  CompanyAttendanceController attendanceController = CompanyAttendanceController();
  late CompanyAttendanceModel attendanceModel;
  List<ListElement> attendanceList = [];
  CompanyHourController hourController = CompanyHourController();
  late CompanyHourModel hourModel;
  List<HoursList> hourList = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await attendanceController.getAttendance(context).then((value) {
      setState(() {
        attendanceModel = value;
        attendanceList = attendanceModel.data.list;
        loading = false;
      });
    });
    await hourController.getHour(context).then((value) {
      setState(() {
        hourModel = value;
        hourList = hourModel.data.hoursList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Attendance", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
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
              child: SizedBox(
                height: 40,
                child: TextField(
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
                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorGray, width: 1.0),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
                          fillColor: colorScreenBg,
                          filled: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorGray, width: 1.0),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
                          fillColor: colorScreenBg,
                          filled: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorGray, width: 1.0),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Print',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Export To CSV',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Export To Excel',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Export To PDF',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: attendanceList.length,
                      itemBuilder: (context, index) {
                        var detail = attendanceList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                border: Border.all(width: 1, color: appThemeBlue),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detail.name,
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Employee ID: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "123",
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Company Name: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Test",
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Date: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              detail.date.toString(),
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Work Hours: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "0.14266666666667",
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Break Time: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "6.60 Min",
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "In: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "11:05:24 am",
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Out: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "11:19:30 am",
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Location Address: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                viewAddress(context, detail.location);
                                              },
                                              child: Text(
                                                "View location",
                                                style: TextStyle(fontSize: 14, color: appThemeBlue),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Hours: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                viewHours(context, hourList);
                                              },
                                              child: Text(
                                                "View Hour's",
                                                style: TextStyle(fontSize: 14, color: appThemeBlue),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Image: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAttendanceImage()));
                                              },
                                              child: Text(
                                                "View Image",
                                                style: TextStyle(fontSize: 14, color: appThemeBlue),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Map: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAttendanceLocation()));
                                              },
                                              child: Text(
                                                "View Map",
                                                style: TextStyle(fontSize: 14, color: appThemeBlue),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Time Zone: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "IST",
                                              style: TextStyle(fontSize: 14, color: appThemeBlue),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Container(
                                        width: double.infinity,
                                        height: 35,
                                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditAttendanceList()));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15))),
                                                  height: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 8.0),
                                                        child: Text(
                                                          "Edit",
                                                          style: TextStyle(fontSize: 14, color: Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(color: colorred, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15))),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
