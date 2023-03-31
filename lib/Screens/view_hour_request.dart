import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../CommonWidget/CommonAppbar.dart';
import '../Controller/EmployeeController/employee_get_hour_request_controller.dart';
import '../Models/EmployeeModel/employee_get_hour_request_model.dart';
import '../utils/Colors.dart';

class ViewHourRequest extends StatefulWidget {
  const ViewHourRequest({Key? key}) : super(key: key);

  @override
  State<ViewHourRequest> createState() => _ViewHourRequestState();
}

class _ViewHourRequestState extends State<ViewHourRequest> {
  EmployeeGetHourRequestController employeeGetHourRequestController =
      EmployeeGetHourRequestController();
  late EmployeeGetHourRequestModel employeeGetHourRequestModel;
  List<ListElement> requestList = [];

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    employeeGetHourRequestController.getEmployeeRequest(context).then((value) {
      setState(() {
        employeeGetHourRequestModel = value;
        print(value.message);
        requestList = employeeGetHourRequestModel.data.list;
        print(requestList.length);
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: CommonAppbar(),
      body: SingleChildScrollView(
        child: Column(children: [
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
                  contentPadding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(7)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorGray, width: 1.0),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: requestList.length,
              itemBuilder: (context, index) {
                var detail = requestList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(2, 5),
                        ),
                      ],
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
                                detail.employeeName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Request date: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    detail.attendanceDateIn.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Attendance In Date: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    detail.attendanceDateIn.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Attendance Out Date: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    detail.attendanceDateOut.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "In Time: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    detail.inTime,
                                    style: TextStyle(
                                        fontSize: 14, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Out Time: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    detail.outTime,
                                    style: TextStyle(
                                        fontSize: 14, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Message:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                      child: Text(
                                    detail.message,
                                    style: TextStyle(
                                        fontSize: 14, color: colorTextGray),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Container(
                            width: double.infinity,
                            height: 35,
                            decoration: BoxDecoration(
                                color: colorButtonYellow,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Center(
                                child: Text(
                                  "View Image",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colorTextYellow,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                );
              }),
        ]),
      ),
    );
  }
}
