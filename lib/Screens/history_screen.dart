import 'package:etsemployee/Controller/EmployeeController/employee_attendance_history_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_attendance_history_model.dart';
import 'package:etsemployee/Screens/view_history_image.dart';
import 'package:etsemployee/Screens/view_history_map.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool loading = false;
  EmployeeAttendanceHistoryController employeeAttendanceHistoryController = EmployeeAttendanceHistoryController();
  late EmployeeAttendanceHistoryModel employeeAttendanceHistoryModel;
  List<ListElement> historyList = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await employeeAttendanceHistoryController.getAttendanceHistory(context).then((value) {
      setState(() {
        employeeAttendanceHistoryModel = value;
        historyList = employeeAttendanceHistoryModel.data.list;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: ListView(
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
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
                                              Expanded(
                                                child: Row(
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
                                              ),
                                              Expanded(
                                                child: Row(
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
                                                  children: [
                                                    const Text(
                                                      "In Time: ",
                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "10:00:00 am",
                                                      style: TextStyle(fontSize: 14, color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Out Time: ",
                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "08:00:00 pm",
                                                      style: TextStyle(fontSize: 14, color: colorTextGray),
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
                                                  "Location Address: ",
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
                          }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
