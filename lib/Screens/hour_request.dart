import 'package:etsemployee/Screens/view_hour_request.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../Controller/EmployeeController/employee_send_hour_request_controller.dart';
import '../Models/EmployeeModel/employee_send_hour_request_model.dart';
import '../Network/api_constant.dart';
import '../utils/Colors.dart';
import 'package:intl/intl.dart';

class HourRequest extends StatefulWidget {
  const HourRequest({Key? key}) : super(key: key);

  @override
  State<HourRequest> createState() => _HourRequestState();
}

class _HourRequestState extends State<HourRequest> {
  EmployeeSendHourRequestController employeeSendHourRequestController =
      EmployeeSendHourRequestController();
  late EmployeeSendHourRequestModel employeeSendHourRequestModel;

  @override
  void initState() {
    // TODO: implement initState
    employeeSendHourRequestController.attendanceIn.text = "";
    employeeSendHourRequestController.attendanceOut.text = "";
    employeeSendHourRequestController.inTime.text = "";
    employeeSendHourRequestController.outTime.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: SingleChildScrollView(
          child: Container(
        color: colorScreenBg,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewHourRequest()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_red_eye,
                        color: appThemeBlue,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "View Fix Hours Request",
                          style: TextStyle(fontSize: 16, color: appThemeBlue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "Attendance In Date *",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        controller:
                            employeeSendHourRequestController.attendanceIn,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Icon(
                              Icons.calendar_today,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: '01/11/2023',
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
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              employeeSendHourRequestController
                                      .attendanceIn.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "Attendance Out Date *",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        controller:
                            employeeSendHourRequestController.attendanceOut,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Icon(
                              Icons.calendar_today,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: '01/11/2023',
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
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              employeeSendHourRequestController
                                      .attendanceOut.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "In Time *",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        controller: employeeSendHourRequestController.inTime,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Icon(
                              Icons.watch_later_outlined,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: '04:32 PM',
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
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              employeeSendHourRequestController.inTime.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "Out Time *",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        controller: employeeSendHourRequestController.outTime,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Icon(
                              Icons.watch_later_outlined,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: '04:32 PM',
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
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              employeeSendHourRequestController.outTime.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "Message *",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: colorGray),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextField(
                          controller: employeeSendHourRequestController.message,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Message',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 12, top: 6, bottom: 6),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          employeeSendHourRequestController
                              .addHourRequest(context)
                              .then((value) {
                            employeeSendHourRequestModel = value;

                            print(ApiConstant.userToken);
                            print(employeeSendHourRequestModel.message);

                            print(employeeSendHourRequestController
                                .attendanceIn.text);
                            print(employeeSendHourRequestController
                                .attendanceOut.text);
                            print(
                                employeeSendHourRequestController.inTime.text);
                            print(
                                employeeSendHourRequestController.outTime.text);
                            print(
                                employeeSendHourRequestController.message.text);
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
                                'Send Request',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
