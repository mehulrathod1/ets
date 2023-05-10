import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Controller/CompanyController/company_report_controller.dart';
import '../../Models/CompanyModels/company_report_model.dart';
import '../../utils/Colors.dart';
import 'monthly_report.dart';

class ManageReport extends StatefulWidget {
  const ManageReport({Key? key}) : super(key: key);

  @override
  State<ManageReport> createState() => _ManageReportState();
}

class _ManageReportState extends State<ManageReport> {
  CompanyReportController reportController = CompanyReportController();
  late CompanyReportModel reportModel;
  List<ListElement> reportList = [];
  bool loader = false;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loader = true;

    reportController.getAllReport(context).then((value) {
      setState(() {
        if (value != null) {
          reportModel = value;
          reportList = reportModel.data.list;
          loader = false;
        } else {
          reportList.clear();
          loader = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No Report Found'),
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
      body: loader
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        style: TextStyle(fontSize: 18, color: Colors.black),
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
                          contentPadding:
                              EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reportList.length,
                        itemBuilder: (context, index) {
                          var data = reportList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                  child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  border:
                                      Border.all(width: 1, color: appThemeBlue),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.employeeName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
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
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Total Hours: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      data.totalHrs,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Break Hours: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      data.breakHrs,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MonthlyReport(
                                                        reportId: data.id,
                                                      )));
                                        },
                                        child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: appThemeBlue,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: appThemeBlue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15))),
                                              height: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "View Detail",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
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
