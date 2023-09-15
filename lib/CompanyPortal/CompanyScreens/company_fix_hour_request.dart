import 'package:etsemployee/Controller/CompanyController/company_hour_accept_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_hour_reject_controlller.dart';
import 'package:etsemployee/Controller/CompanyController/company_hour_request_controller.dart';
import 'package:etsemployee/Models/CompanyModels/companay_hour_request.dart';
import 'package:etsemployee/Models/CompanyModels/companyAcceptHourModel.dart';
import 'package:etsemployee/Models/CompanyModels/company_hour_reject_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../Network/api_constant.dart';

class CompanyFixHourRequest extends StatefulWidget {
  CompanyFixHourRequest({required this.appBar, Key? key}) : super(key: key);

  bool appBar;

  @override
  State<CompanyFixHourRequest> createState() => _CompanyFixHourRequestState();
}

class _CompanyFixHourRequestState extends State<CompanyFixHourRequest> {
  bool loading = false;

  String? date;
  CompanyFixHourRequestController hourRequestController =
      CompanyFixHourRequestController();
  late CompanyHourRequestModel hourRequestModel;
  late CompanyHourAcceptModel hourAcceptModel;
  late CompanyHourRejectModel hourRejectModel;
  List<ListElement> requestList = [];
  CompanyAcceptHourController acceptHourController =
      CompanyAcceptHourController();
  ClassHourRejectController hourRejectController = ClassHourRejectController();

  Future initialize(BuildContext context) async {
    loading = true;
    await hourRequestController.getHourRequest(context).then((value) {
      setState(() {
        if (value != null) {
          hourRequestModel = value;
          requestList = hourRequestModel.data.list;
          debugPrint(hourRequestModel.message);
          loading = false;
        } else {
          requestList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No Request found'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  Future requestDetail(
      BuildContext context,
      String attendanceIn,
      String attendanceOut,
      String inTime,
      String outTime,
      String message) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Request Detail',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Attendance In Date : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          attendanceIn,
                          style:
                              TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Attendance Out Date : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          attendanceOut,
                          style:
                              TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "In Time : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          inTime,
                          style: TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Out Time : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          outTime,
                          style: TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                    "Message : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          style: TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    initialize(context);
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
                child: Text("Fix Hour Request",
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        var data = requestList[index];
                        date = DateFormat('dd-MM-yyy').format(data.createAt);

                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
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
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Date: ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              date!,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: appThemeBlue,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                requestDetail(
                                                    context,
                                                    DateFormat('dd-MM-yyy')
                                                        .format(data
                                                            .attendanceDateIn),
                                                    DateFormat('dd-MM-yyy')
                                                        .format(data
                                                            .attendanceDateOut),
                                                    data.inTime,
                                                    data.outTime,
                                                    data.message);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: appThemeBlue,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15))),
                                                height: double.infinity,
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .remove_red_eye_sharp,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          data.status == '1'
                                              ? Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // acceptHourController
                                                      //     .acceptHourRequest(
                                                      //         context, data.id)
                                                      //     .then((value) {
                                                      //   debugPrint(value.data);
                                                      //   initialize(context);
                                                      //   debugPrint(data.id);
                                                      // });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15)),
                                                          color: appThemeGreen),
                                                      height: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              "Accepted",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : data.status == '2'
                                                  ? Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // hourRejectController
                                                          //     .rejectHourRequest(
                                                          //         context,
                                                          //         data.id
                                                          //             .toString())
                                                          //     .then((value) {
                                                          //   initialize(context);
                                                          //
                                                          //   debugPrint(
                                                          //       value.message);
                                                          // });
                                                        },
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius: BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15))),
                                                          height:
                                                              double.infinity,
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  "Rejected",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                acceptHourController
                                                                    .acceptHourRequest(
                                                                        context,
                                                                        data.id)
                                                                    .then(
                                                                        (value) {
                                                                  initialize(
                                                                      context);
                                                                  debugPrint(
                                                                      data.id);
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color:
                                                                            appThemeGreen),
                                                                height: double
                                                                    .infinity,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "Accept",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                hourRejectController
                                                                    .rejectHourRequest(
                                                                        context,
                                                                        data.id
                                                                            .toString())
                                                                    .then(
                                                                        (value) {
                                                                  initialize(
                                                                      context);
                                                                  ;
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.only(
                                                                            bottomRight:
                                                                                Radius.circular(15))),
                                                                height: double
                                                                    .infinity,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "Reject",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
