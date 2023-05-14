import 'package:etsemployee/Controller/CompanyController/company_hour_accept_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_hour_reject_controlller.dart';
import 'package:etsemployee/Controller/CompanyController/company_hour_request_controller.dart';
import 'package:etsemployee/Models/CompanyModels/companay_hour_request.dart';
import 'package:etsemployee/Models/CompanyModels/companyAcceptHourModel.dart';
import 'package:etsemployee/Models/CompanyModels/company_hour_reject_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompanyFixHourRequest extends StatefulWidget {
  const CompanyFixHourRequest({Key? key}) : super(key: key);

  @override
  State<CompanyFixHourRequest> createState() => _CompanyFixHourRequestState();
}

class _CompanyFixHourRequestState extends State<CompanyFixHourRequest> {
  bool loading = false;
  bool acceptRequest = false;
  bool accepted = false;
  bool rejected = false;
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

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Request Detail',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Attendance In Date : ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            attendanceIn,
                            style:
                                TextStyle(fontSize: 14, color: colorTextGray),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: const Text(
                            "Attendance Out Date : ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            attendanceOut,
                            style:
                                TextStyle(fontSize: 14, color: colorTextGray),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Text(
                                "In Time : ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                inTime,
                                style: TextStyle(
                                    fontSize: 14, color: colorTextGray),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Text(
                                "Out Time : ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                outTime,
                                style: TextStyle(
                                    fontSize: 14, color: colorTextGray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Message : ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: Expanded(
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 14, color: colorTextGray),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        var data = requestList[index];
                        date = DateFormat('dd-MM-yyy').format(data.createAt);
                        if (data.status == '1') {
                          accepted = true;
                        } else {
                          accepted = false;
                        }
                        if (data.status == '2') {
                          rejected = true;
                        } else {
                          rejected = false;
                        }
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
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
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
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                acceptHourController
                                                    .acceptHourRequest(
                                                        context, data.id)
                                                    .then((value) {
                                                  debugPrint(value.data);
                                                  initialize(context);
                                                  debugPrint(data.id);
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: accepted
                                                      ? appThemeGreen
                                                      : appThemeteallight,
                                                ),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                        "Accept",
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
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                hourRejectController
                                                    .rejectHourRequest(context,
                                                        data.id.toString())
                                                    .then((value) {
                                                  initialize(context);

                                                  debugPrint(value.message);
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: accepted
                                                        ? Colors.red.shade300
                                                        : Colors.red,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15))),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                        "Reject",
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
