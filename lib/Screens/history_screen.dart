import 'package:etsemployee/Controller/EmployeeController/employee_attendance_history_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_attendance_history_model.dart';
import 'package:etsemployee/Screens/view_history_image.dart';
import 'package:etsemployee/Screens/view_history_map.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool loading = false;
  ScrollController? controller;
  EmployeeAttendanceHistoryController employeeAttendanceHistoryController = EmployeeAttendanceHistoryController();
  late EmployeeAttendanceHistoryModel employeeAttendanceHistoryModel;
  TextEditingController startDate = TextEditingController(text: "");
  TextEditingController endDate = TextEditingController(text: "");
  int page = 1;
  int totalPage = 0;
  List<ListElement> historyList = [];

  Future initialize(BuildContext context) async {
    loading = true;
    page = 1;
    totalPage = 0;
    startDate.clear();
    endDate.clear();
    await employeeAttendanceHistoryController.getAttendanceHistory(context: context, startDate: startDate.text, endDate: endDate.text, page: page).then((value) {
      if (value != null) {
        setState(() {
          employeeAttendanceHistoryModel = value;
          historyList = employeeAttendanceHistoryModel.data.list;
          totalPage = employeeAttendanceHistoryModel.data.paginationInfo.totalPages;
          page = page + 1;
          loading = false;
        });
      }
    });
    controller = ScrollController()..addListener(scrollListener);
  }

  Future scrollListener() async {
    if (totalPage == page) {
      return;
    }
    if (controller!.position.extentAfter <= 0 && loading == false) {
      loading = true;
      await employeeAttendanceHistoryController.getAttendanceHistory(context: context, startDate: startDate.text, endDate: endDate.text, page: page).then((value) {
        if (value != null) {
          setState(() {
            employeeAttendanceHistoryModel = value;
            historyList.addAll(employeeAttendanceHistoryModel.data.list);
            totalPage = employeeAttendanceHistoryModel.data.paginationInfo.totalPages;
            page = page + 1;
            loading = false;
          });
        }
      });
    }
  }

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  @override
  void dispose() {
    controller!.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: ListView(
        controller: controller,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                              padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                              child: Text(
                                "Start Date: ",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                controller: startDate,
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
                                  hintText: '01/11/2023',
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
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                                    setState(() {
                                      startDate.text = formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    debugPrint("Date is not selected");
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
                              padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                              child: Text(
                                "End Date:",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                controller: endDate,
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
                                  hintText: '01/11/2023',
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
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                                    setState(() {
                                      endDate.text = formattedDate;
                                    });
                                  } else {
                                    debugPrint("Date is not selected");
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (startDate.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Please select start date first."),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (endDate.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Please select end date first."),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        loading = true;
                        page = 1;
                        totalPage = 0;
                        historyList.clear();
                        await employeeAttendanceHistoryController.getAttendanceHistory(context: context, startDate: startDate.text, endDate: endDate.text, page: page).then((value) {
                          if (value != null) {
                            setState(() {
                              employeeAttendanceHistoryModel = value;
                              historyList = employeeAttendanceHistoryModel.data.list;
                              totalPage = employeeAttendanceHistoryModel.data.paginationInfo.totalPages;
                              page = page + 1;
                              loading = false;
                            });
                          }
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      await initialize(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: colorred, borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Clear Filter',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : historyList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: historyList.length,
                              itemBuilder: (context, index) {
                                var detail = historyList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
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
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, top: 16),
                                              child: Text(
                                                detail.name,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Date : ",
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      DateFormat('yyyy-MM-dd').format(detail.date),
                                                      style: TextStyle(fontSize: 14, color: colorTextGray),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "In Time : ",
                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "10:00:00 am",
                                                            style: TextStyle(fontSize: 14, color: colorTextGray),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "Out Time : ",
                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "08:00:00 pm",
                                                            style: TextStyle(fontSize: 14, color: colorTextGray),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      "Location Address : ",
                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      detail.location,
                                                      style: TextStyle(fontSize: 14, color: colorTextGray),
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
                                                decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewHistoryImage()));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: const [
                                                            Icon(
                                                              Icons.remove_red_eye,
                                                              color: Colors.white,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                "View Image",
                                                                style: TextStyle(fontSize: 14, color: Colors.white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                      height: 35,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(color: Colors.white),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewHistoryMap()));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: const [
                                                            Icon(
                                                              Icons.remove_red_eye,
                                                              color: Colors.white,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                "View Map",
                                                                style: TextStyle(fontSize: 14, color: Colors.white),
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const Text(
                              "Oops!, No data found.",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
