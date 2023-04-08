import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_employee_detail.dart';

class EditAttendanceList extends StatefulWidget {
  const EditAttendanceList({Key? key}) : super(key: key);

  @override
  State<EditAttendanceList> createState() => _EditAttendanceListState();
}

class _EditAttendanceListState extends State<EditAttendanceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Attendance", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                                  const Text(
                                    "Kate Thomas test",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Employee ID: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "123",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Company Name: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Test",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Date: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Jan 03,2023",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Work Hours: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "0.14266666666667",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Break Time: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "6.60 Min",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "In: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "11:05:24 am",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Out: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "11:19:30 am",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Location Address: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Shree Ram Jambu, Raiya Road, Rajkot, Gujarat",
                                          style: TextStyle(fontSize: 14, color: colorTextGray),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditEmployeeDetail()));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15))),
                                            height: double.infinity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8.0),
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(color: colorred, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15))),
                                          height: double.infinity,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.delete_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
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
