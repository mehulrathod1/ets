import 'dart:convert';

import 'package:etsemployee/CompanyPortal/CompanyScreens/view_attendance.dart';
import 'package:etsemployee/Controller/CompanyController/get_company_employee_controller.dart';
import 'package:etsemployee/Models/CompanyModels/GetCompanyEmployeeModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Controller/CompanyController/company_call_request_controller.dart';
import '../../Controller/CompanyController/company_delete_employee_controller.dart';
import '../../Controller/CompanyController/company_send_location_controller.dart';
import '../../Models/CompanyModels/company_call_request.dart';
import '../../Models/CompanyModels/company_delete_employee_model.dart';
import '../../Models/CompanyModels/company_send_location_request_model.dart';
import '../../Screens/live_location.dart';
import '../../utils/Colors.dart';
import '../PopUps/call_for_attendance.dart';
import '../PopUps/location_request.dart';
import 'add_employee.dart';
import 'edit_employee.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({Key? key}) : super(key: key);

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  GetCompanyEmployeeController getCompanyEmployeeController =
      GetCompanyEmployeeController();
  late GetCompanyEmployeeModel getCompanyEmployeeModel;
  List<ListElement> employeeList = [];

  CompanyLocationRequestController locationRequestController =
      CompanyLocationRequestController();
  late CompanyLocationRequestModel locationRequestModel;

  CompanyCallRequestController callRequestController =
      CompanyCallRequestController();
  late CompanyCallRequestModel callRequestModel;

  CompanyDeleteCompanyController deleteCompanyController =
      CompanyDeleteCompanyController();
  late CompanyDeleteEmployeeModel deleteEmployeeModel;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    getCompanyEmployeeController.getCompanyEmployee(context).then((value) {
      setState(() {
        getCompanyEmployeeModel = value;
        print(value.message);
        employeeList = getCompanyEmployeeModel.data.list;
        print(employeeList.length);
        //
      });
    });
  }

  Future locationRequest(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Location Request',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          locationRequestController
                              .sendLocationRequest(context)
                              .then((value) {
                            locationRequestModel = value;
                            print(locationRequestModel.message);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeGreen,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Sent',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future callForAttendance(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Call For Attendance',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: appThemeBlue,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  callRequestController
                                      .sendCallRequest(context)
                                      .then((value) {
                                    callRequestModel = value;

                                    print(callRequestModel.message);

                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: appThemeGreen,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        'Sent',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
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
                          hintText: 'Search here...',
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
                ),
                Expanded(
                  child: Padding(
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
                              Icons.keyboard_arrow_down_outlined,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: 'Select Department',
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
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEmployee()));
                      },
                      child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color: appThemeGreen,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'Add Employee',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )),
                    ),
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
                            child: Text(
                              'Print',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                            onTap: () {},
                            child: Text(
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
                            child: Text(
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
                            child: Text(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    var detail = employeeList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
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
                                      detail.employeeName,
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
                                          "Department: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          detail.department.name,
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
                                        Text(
                                          "Email:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          detail.email.name,
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
                                        Text(
                                          "Total Hours:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          detail.totalHrs.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: colorTextGray),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAttendance()));
                                      },
                                      child: Text(
                                        "View Attendance",
                                        style: TextStyle(
                                            fontSize: 14, color: appThemeBlue),
                                      ),
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
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditEmployee()));
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              locationRequest(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorOrange),
                                              height: double.infinity,
                                              child: Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LiveLocation()));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: appThemeBlue),
                                              height: double.infinity,
                                              child: Icon(
                                                Icons.menu_book_sharp,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              callForAttendance(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: appThemeGreen),
                                              height: double.infinity,
                                              child: Icon(
                                                Icons.call,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: appThemeBlue),
                                            height: double.infinity,
                                            child: Icon(
                                              Icons.play_arrow_sharp,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              deleteCompanyController
                                                  .deleteEmployee(context,
                                                      detail.employeeId)
                                                  .then((value) {
                                                deleteEmployeeModel = value;
                                                print(detail.employeeId);
                                                initialize(context);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorred,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15))),
                                              height: double.infinity,
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
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
