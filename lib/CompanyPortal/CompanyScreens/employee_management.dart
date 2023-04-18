import 'package:etsemployee/CompanyPortal/CompanyScreens/view_attendance.dart';
import 'package:etsemployee/Controller/CompanyController/company_call_request_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_delete_employee_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_send_location_controller.dart';
import 'package:etsemployee/Controller/CompanyController/get_company_employee_controller.dart';
import 'package:etsemployee/Models/CompanyModels/GetCompanyEmployeeModel.dart';
import 'package:etsemployee/Screens/live_location.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'add_employee.dart';
import 'edit_employee.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({Key? key}) : super(key: key);

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  bool loading = false;
  List<ListElement> employeeList = [];
  late GetCompanyEmployeeModel getCompanyEmployeeModel;
  GetCompanyEmployeeController getCompanyEmployeeController =
      GetCompanyEmployeeController();
  CompanyLocationRequestController locationRequestController =
      CompanyLocationRequestController();
  CompanyCallRequestController callRequestController =
      CompanyCallRequestController();
  CompanyDeleteCompanyController deleteCompanyController =
      CompanyDeleteCompanyController();

  Future initialize(BuildContext context) async {
    loading = true;
    await getCompanyEmployeeController
        .getCompanyEmployee(context)
        .then((value) {
      setState(() {
        getCompanyEmployeeModel = value;
        employeeList = getCompanyEmployeeModel.data.list;
        loading = false;
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
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Location Request',
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
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        locationRequestController
                            .sendLocationRequest(context)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Sent',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Center(
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
                        child: const Icon(
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
                              child: const Center(
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
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
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appThemeGreen,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                  child: Text(
                                    'Sent',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
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
                      ),
                    ],
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
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: '01/19/2023',
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: '01/19/2023',
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
                                      builder: (context) =>
                                          const AddEmployee()));
                            },
                            child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appThemeGreen,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                  child: Text(
                                    'Add Employee',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: employeeList.length,
                        itemBuilder: (context, index) {
                          var detail = employeeList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
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
                                            detail.employeeName,
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
                                                "Department: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "detail.department.",
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
                                              const Text(
                                                "Email:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                detail.email.name,
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
                                              const Text(
                                                "Total Hours:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                detail.totalHrs.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ViewAttendance()));
                                            },
                                            child: Text(
                                              "View Attendance",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: appThemeBlue),
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EditEmployee()));
                                                },
                                                child: const Icon(
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
                                                  child: const Icon(
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
                                                          const LiveLocation(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: appThemeBlue),
                                                  height: double.infinity,
                                                  child: const Icon(
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
                                                  child: const Icon(
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
                                                child: const Icon(
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
                                                    initialize(context);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: colorred,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                  height: double.infinity,
                                                  child: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                    size: 20,
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
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
