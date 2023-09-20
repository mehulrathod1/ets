import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/CompanyPortal/CompanyScreens/view_attendance.dart';
import 'package:etsemployee/Controller/CompanyController/company_call_request_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_delete_employee_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_send_location_controller.dart';
import 'package:etsemployee/Controller/CompanyController/compnay_login_controller.dart';
import 'package:etsemployee/Controller/CompanyController/get_company_employee_controller.dart';
import 'package:etsemployee/Models/CompanyModels/GetCompanyEmployeeModel.dart';
import 'package:etsemployee/Models/CompanyModels/converted_file.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import '../../Controller/CompanyController/company_add_employee_controller.dart';
import '../../Controller/CompanyController/company_hold_access_controller.dart';
import '../../Network/api_constant.dart';
import '../PopUps/delete_conformation_popup.dart';
import 'add_employee.dart';
import 'edit_employee.dart';

import 'employee_live_location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class EmployeeManagement extends StatefulWidget {
  EmployeeManagement({required this.appBar, Key? key}) : super(key: key);
  bool appBar;

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  bool loading = false;
  List<ListElement> employeeList = [];



  List<String> excel = [];
  String selectedDepartment = "Select Department";
  String result = '';
  var detail;
  List data=[];
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController searchText = TextEditingController();
  List<DropdownMenuItem<Object?>> departmentListItems = [];

  late GetCompanyEmployeeModel getCompanyEmployeeModel;
  GetCompanyEmployeeController getCompanyEmployeeController = GetCompanyEmployeeController();
  CompanyLocationRequestController locationRequestController = CompanyLocationRequestController();
  CompanyCallRequestController callRequestController = CompanyCallRequestController();
  CompanyDeleteCompanyController deleteCompanyController = CompanyDeleteCompanyController();
  CompanyHoldAccessController holdAccessController = CompanyHoldAccessController();
  CompanyAddEmployeeController addEmployeeController = CompanyAddEmployeeController();

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      // addTaskController.orderId.text = selectedTest['estimate_id'];
      selectedDepartment = selectedTest['department_name'];
      addEmployeeController.department.text = selectedTest['id'];
      print(selectedTest['id']);
    });
  }

  List<DropdownMenuItem<Object?>> buildTaskSizeListItems(xyz) {
    List<DropdownMenuItem<Object?>> items = [];
    items.clear();
    for (var i in xyz) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['department_name'],
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  Future initialize(BuildContext context, String search, String department,
      String startDate, String endDate) async {
    setState(() {
      loading = true;
    });
    await getCompanyEmployeeController
        .getCompanyEmployee(context,
            search: search,
            page: 1,
            department: department,
            startDate: startDate,
            endDate: endDate)
        .then((value) {
      setState(() {
        if (value != null) {
          getCompanyEmployeeModel = value;
          employeeList = getCompanyEmployeeModel.data.list;
          print("----------------------------------------------${getCompanyEmployeeModel.data.list[0].email}");
          setState(() {});
          loading = false;
        } else {
          employeeList.clear();
          loading = false;
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('No data found'),
          //     duration: const Duration(seconds: 2),
          //   ),
          // );
        }
      });
    });
  }

  Future locationRequest(BuildContext context, String id) async {
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
                        print(id);
                        locationRequestController
                            .sendLocationRequest(context, id)
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

  Future callForAttendance(BuildContext context, String id) async {
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
                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: Container(
                        //       height: 40,
                        //       decoration: BoxDecoration(
                        //           color: appThemeBlue,
                        //           borderRadius: BorderRadius.circular(8)),
                        //       child: const Center(
                        //         child: Text(
                        //           'View Details',
                        //           style: TextStyle(
                        //               color: Colors.white, fontSize: 18),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                callRequestController
                                    .sendCallRequest(context, id)
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
                                    'Sent Request',
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

  void refreshData() {
    setState(() {
      initialize(context, '', '', '', '');
    });
  }



  CSVDowunloadModel? csvDowunloadModel;

  Future downloadCSV(BuildContext context, String id) async {
    await getCompanyEmployeeController.downloadCSVFile(context, id).then((value) async{
      if (value != null) {
        csvDowunloadModel = value;
        print(csvDowunloadModel!.data!.downloadUrl);
        try {
          final File? file = await FileDownloader.downloadFile(
              url: csvDowunloadModel!.data!.downloadUrl!,
              name: "employee_list.csv"
          );
          print('FILE: ${file?.path}');
        } catch (error) {
          print('Error downloading file: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(csvDowunloadModel!.message!),
            duration: const Duration(seconds: 2),
          ),
        );
      }

    });
  }
  Future downloadExcel(BuildContext context, String id) async {
    await getCompanyEmployeeController.downloadExcelFile(context,id).then((value) async{
      if (value != null) {
        csvDowunloadModel = value;
        print(csvDowunloadModel!.data!.downloadUrl);
        try {
          final File? file = await FileDownloader.downloadFile(
              url: csvDowunloadModel!.data!.downloadUrl!,
              name: "employee_list.excel"
          );
          print('FILE: ${file?.path}');
        } catch (error) {
          print('Error downloading file: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(csvDowunloadModel!.message!),
            duration: const Duration(seconds: 2),
          ),
        );
      }

    });
  }
  Future downloadPDF(BuildContext context, String id) async {
    await getCompanyEmployeeController.downloadPDFFile(context, id).then((value) async{
      if (value != null) {
        csvDowunloadModel = value;
        print(csvDowunloadModel!.data!.downloadUrl!);
        try {
          final File? file = await FileDownloader.downloadFile(
              url: csvDowunloadModel!.data!.downloadUrl!,
              name: "employee_list.pdf"
          );
          print('FILE: ${file?.path}');
        } catch (error) {
          print('Error downloading file: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(csvDowunloadModel!.message!),
            duration: const Duration(seconds: 2),
          ),
        );
      }

    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () {
      addEmployeeController.getDepartmentList(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  departmentListItems = buildTaskSizeListItems(value);
                }),
              }
            else
              {
                setState(() {
                  departmentListItems.clear();
                }),
              }
          });
    });
    initialize(context, '', '', '', '');
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
                child: Text("Employee",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
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
      body: Column(
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
                      textInputAction: TextInputAction.search,
                      controller: searchText,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
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
                            const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGray, width: 1.0),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onSubmitted: (value) {
                        print(loading);
                        initialize(context, value, '', '', '');
                      },
                      onChanged: (value) {
                        initialize(context, value, '', '', '');
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: DropdownBelow(
                      itemWidth: MediaQuery.of(context).size.width - 130,
                      itemTextstyle:
                          const TextStyle(fontSize: 18, color: Colors.black),
                      boxTextstyle:
                          const TextStyle(fontSize: 18, color: Colors.black),
                      boxWidth: MediaQuery.of(context).size.width,
                      boxHeight: 40,
                      boxDecoration: BoxDecoration(
                        color: colorScreenBg,
                        border: Border.all(color: colorGray, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7.0)),
                      ),
                      boxPadding: const EdgeInsets.only(
                          left: 12, top: 6, bottom: 6, right: 10),
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: appThemeGreen,
                      ),
                      hint: Text(
                        selectedDepartment,
                        style: TextStyle(
                            fontSize: 13,
                            color: selectedDepartment == "Test Estimate Section"
                                ? Colors.black.withOpacity(0.60)
                                : Colors.black),
                      ),
                      onChanged: onChangeDropdownBoxSize,
                      items: departmentListItems),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: startDate,
                      style: const TextStyle(
                          height: 1.7, fontSize: 16, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Select StartDate',
                        fillColor: colorScreenBg,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGray, width: 1.0),
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
                              DateFormat('yyyy-MM-dd').format(pickedDate);
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
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: endDate,
                      style: const TextStyle(
                          height: 1.7, fontSize: 16, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Select EndDate',
                        fillColor: colorScreenBg,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGray, width: 1.0),
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
                              DateFormat('yyyy-MM-dd').format(pickedDate);
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
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint(searchText.text);
                      debugPrint(addEmployeeController.department.text);
                      debugPrint(startDate.text);
                      debugPrint(endDate.text);

                      initialize(
                          context,
                          searchText.text,
                          addEmployeeController.department.text,
                          startDate.text,
                          endDate.text);
                    },
                    child: Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        searchText.clear();
                        addEmployeeController.department.clear();
                        startDate.clear();
                        endDate.clear();
                        selectedDepartment = "Select Department";
                      });

                      initialize(context, '', '', '', '');
                      debugPrint(searchText.text);
                      debugPrint(addEmployeeController.department.text);
                      debugPrint(startDate.text);
                      debugPrint(endDate.text);
                    },
                    child: Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                            color: appThemeBlue,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Clear filter',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
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
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEmployee(
                                    callback: () {
                                      refreshData();
                                    },
                                  )));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Add Employee',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                          color: appThemeBlue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Print',
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                          color: appThemeBlue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: GestureDetector(
                          onTap: ()  {
                            downloadCSV(context,CompanyID);

                          },
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
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                          color: appThemeBlue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {

                            downloadExcel(context,CompanyID);
                          },
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
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                        color: appThemeBlue,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          downloadPDF(context,CompanyID);
                        },
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
          loading
              ? const Center(child: CircularProgressIndicator())
              : employeeList.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: employeeList.length,
                            itemBuilder: (context, index) {
                              var detail = employeeList[index];
                             // data.add(employeeList[index].employeeId);
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
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
                                                detail.employeeName,
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
                                                    "Department: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    detail.department!,
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
                                                    detail.email,
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
                                                              ViewAttendance(
                                                                employeeId: detail
                                                                    .employeeId,
                                                              )));
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
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
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
                                                            Radius.circular(
                                                                15))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             const EditEmployee()));
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      EditEmployee(
                                                                        employeeId:
                                                                            detail.employeeId,
                                                                        departmentName:
                                                                            detail.department!,
                                                                        callback:
                                                                            () {
                                                                          refreshData();
                                                                        },
                                                                      )));
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
                                                      locationRequest(context,
                                                          detail.employeeId);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: colorOrange),
                                                      height: double.infinity,
                                                      child: const Icon(
                                                        Icons
                                                            .location_on_outlined,
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
                                                              EmployeeLiveLocation(
                                                                  employeeId: detail
                                                                      .employeeId),
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
                                                      callForAttendance(context,
                                                          detail.employeeId);
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
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      holdAccessController
                                                          .holdAccess(
                                                              context,
                                                              detail
                                                                  .employeeId);
                                                    },
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
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return ConfirmationPopup(
                                                            title:
                                                                'Confirmation',
                                                            message:
                                                                'Are you sure you want to delete?',
                                                            onConfirm: () {
                                                              // Perform delete operation here
                                                              deleteCompanyController
                                                                  .deleteEmployee(
                                                                      context,
                                                                      detail
                                                                          .employeeId)
                                                                  .then(
                                                                      (value) {
                                                                initialize(
                                                                    context,
                                                                    '',
                                                                    '',
                                                                    '',
                                                                    '');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                              // Close the dialog
                                                            },
                                                          );
                                                        },
                                                      );
                                                      // deleteCompanyController
                                                      //     .deleteEmployee(context,
                                                      //         detail.employeeId)
                                                      //     .then((value) {
                                                      //   initialize(context);
                                                      // });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: colorred,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  bottomRight: Radius
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
                    )
                  : const Text(
                      'Oops No Employee Found!',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
        ],
      ),
    );
  }
}
