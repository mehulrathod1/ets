import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../Controller/CompanyController/company_monthly_report_controller.dart';
import '../../Controller/CompanyController/company_yearly_report_controller.dart';
import '../../Models/CompanyModels/company_monthly_report.dart';
import '../../Models/CompanyModels/company_yearly_model.dart';
import '../../utils/Colors.dart';

class MonthlyReport extends StatefulWidget {
  MonthlyReport({required this.reportId, Key? key}) : super(key: key);
  String reportId;

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  CompanyMonthlyReportController monthlyReportController =
      CompanyMonthlyReportController();
  late CompanyMonthlyReportModel monthlyReportModel;
  List<ListElement> monthlyList = [];

  CompanyYearlyReportController yearlyReportController =
      CompanyYearlyReportController();
  late CompanyYearlyReportModel yearlyReportModel;
  List<ListData> yearlyList = [];
  bool loading = false;
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  bool manageList = true;
  String reportButton = 'Yearly Report';

  @override
  void initState() {
    // TODO: implement initState
    getMonthlyReport(context);
    super.initState();
  }

  Future getMonthlyReport(BuildContext context) async {
    loading = true;
    await monthlyReportController
        .getMonthlyReport(context, widget.reportId)
        .then((value) {
      setState(() {
        if (value != null) {
          monthlyReportModel = value;
          monthlyList = monthlyReportModel.data.list;
          manageList = false;
          loading = false;
        } else {
          loading = false;
          manageList = false;
        }
      });
    });
  }

  Future getYearlyReport(BuildContext context) async {
    loading = true;
    await yearlyReportController
        .getYearlyReport(context, widget.reportId)
        .then((value) {
      setState(() {
        if (value != null) {
          yearlyReportModel = value;
          yearlyList = yearlyReportModel.data.list;
          manageList = true;
          loading = false;
        } else {
          loading = false;
          manageList = true;
        }
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
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Monthly Report",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Start Date: ",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  controller: startDate,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    suffixIcon: Align(
                                      widthFactor: 1,
                                      heightFactor: 1,
                                      child: ImageIcon(
                                        const AssetImage("assets/calender.png"),
                                        size: 25,
                                        color: appThemeGreen,
                                      ),
                                    ),
                                    hintText: 'Select StartDate',
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('MM/dd/yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        startDate.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 6.0),
                                child: Text(
                                  "End Date:",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextField(
                                  controller: endDate,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    suffixIcon: Align(
                                      widthFactor: 1,
                                      heightFactor: 1,
                                      child: ImageIcon(
                                        AssetImage("assets/calender.png"),
                                        size: 25,
                                        color: appThemeGreen,
                                      ),
                                    ),
                                    hintText: 'Select EndDate',
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('MM/dd/yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        endDate.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
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
                              decoration: BoxDecoration(
                                  color: appThemeBlue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Export To CSV',
                                    style: TextStyle(color: Colors.white),
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
                              decoration: BoxDecoration(
                                  color: appThemeBlue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Export To Excel',
                                    style: TextStyle(
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
                              decoration: BoxDecoration(
                                  color: appThemeBlue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Export To PDF',
                                    style: TextStyle(
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
                              decoration: BoxDecoration(
                                  color: appThemeBlue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (reportButton == 'Yearly Report') {
                                        reportButton = "Monthly Report";
                                        //monthaly call
                                        getMonthlyReport(context);
                                      } else {
                                        reportButton = "Yearly Report";
                                        //yearly call
                                        getYearlyReport(context);
                                      }
                                    });
                                  },
                                  child: Text(
                                    reportButton,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                              decoration: BoxDecoration(
                                  color: appThemeBlue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Print',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  manageList
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: monthlyList.length,
                              itemBuilder: (context, index) {
                                var data = monthlyList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        border: Border.all(
                                            width: 1, color: appThemeBlue),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.empName,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Month: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      data.month,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Total Hours: ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            data.totalHours,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    colorTextGray),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Break Hours: ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            data.breakHours,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    colorTextGray),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: 8,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Month: ",
                                                //       style: TextStyle(
                                                //           fontSize: 14,
                                                //           fontWeight: FontWeight.bold),
                                                //     ),
                                                //     Text(
                                                //       "October-2022",
                                                //       style: TextStyle(
                                                //           fontSize: 14,
                                                //           color: colorTextGray),
                                                //     ),
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: 8,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Expanded(
                                                //       child: Row(
                                                //         children: [
                                                //           Text(
                                                //             "Total Hours: ",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 fontWeight:
                                                //                     FontWeight.bold),
                                                //           ),
                                                //           Text(
                                                //             "1",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 color: colorTextGray),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //     Expanded(
                                                //       child: Row(
                                                //         children: [
                                                //           Text(
                                                //             "Break Hours: ",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 fontWeight:
                                                //                     FontWeight.bold),
                                                //           ),
                                                //           Text(
                                                //             "0",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 color: colorTextGray),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: 8,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Month: ",
                                                //       style: TextStyle(
                                                //           fontSize: 14,
                                                //           fontWeight: FontWeight.bold),
                                                //     ),
                                                //     Text(
                                                //       "October-2022",
                                                //       style: TextStyle(
                                                //           fontSize: 14,
                                                //           color: colorTextGray),
                                                //     ),
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: 8,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Expanded(
                                                //       child: Row(
                                                //         children: [
                                                //           Text(
                                                //             "Total Hours: ",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 fontWeight:
                                                //                     FontWeight.bold),
                                                //           ),
                                                //           Text(
                                                //             "1",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 color: colorTextGray),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //     Expanded(
                                                //       child: Row(
                                                //         children: [
                                                //           Text(
                                                //             "Break Hours: ",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 fontWeight:
                                                //                     FontWeight.bold),
                                                //           ),
                                                //           Text(
                                                //             "0",
                                                //             style: TextStyle(
                                                //                 fontSize: 14,
                                                //                 color: colorTextGray),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                );
                              }),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: yearlyList.length,
                              itemBuilder: (context, index) {
                                var data = yearlyList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        border: Border.all(
                                            width: 1, color: appThemeBlue),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.empName,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Year: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      data.year,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Total Hours: ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            data.totalHours,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    colorTextGray),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Break Hours: ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            data.breakHours,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    colorTextGray),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
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
