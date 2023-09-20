import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:intl/intl.dart';

import '../../Controller/CompanyController/company_add_employee_controller.dart';
import '../../Network/api_constant.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({required this.callback, Key? key}) : super(key: key);
  final VoidCallback callback;

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  CompanyAddEmployeeController addEmployeeController =
      CompanyAddEmployeeController();
  String selectedDepartment = "Select Department";
  List<DropdownMenuItem<Object?>> departmentListItems = [];
  TextEditingController startDate = TextEditingController();

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      // addTaskController.orderId.text = selectedTest['estimate_id'];
      selectedDepartment = selectedTest['department_name'];
      addEmployeeController.department.text = selectedTest['id'];
      print(selectedTest['id']);
    });
  }

  bool _isValidEmail(String email) {
    //final gmailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$');
    final gmailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return gmailRegExp.hasMatch(email);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Add Employee",
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
                    backgroundImage: NetworkImage(ApiConstant.profileImage),
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
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: colorScreenBg,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Employee Name",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addEmployeeController.employeeName,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Employee Email",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addEmployeeController.email,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
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
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                      //   child: Text(
                      //     "creditCard Number",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      //   child: TextField(
                      //     controller: addEmployeeController.creditCardNo,
                      //     keyboardType: TextInputType.number,
                      //     style: const TextStyle(
                      //         height: 1.7, fontSize: 18, color: Colors.black),
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       hintText: 'Enter creditCard Number',
                      //       fillColor: colorScreenBg,
                      //       filled: true,
                      //       isDense: true,
                      //       contentPadding: const EdgeInsets.only(
                      //           left: 12, top: 6, bottom: 6),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.grey, width: 1.0),
                      //           borderRadius: BorderRadius.circular(7)),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: colorGray, width: 1.0),
                      //         borderRadius: BorderRadius.circular(7),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                      //   child: Text(
                      //     "CreditCard Name",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      //   child: TextField(
                      //     controller: addEmployeeController.creditCardName,
                      //     style: const TextStyle(
                      //         height: 1.7, fontSize: 18, color: Colors.black),
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       hintText: 'Enter creditCard Name',
                      //       fillColor: colorScreenBg,
                      //       filled: true,
                      //       isDense: true,
                      //       contentPadding: const EdgeInsets.only(
                      //           left: 12, top: 6, bottom: 6),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.grey, width: 1.0),
                      //           borderRadius: BorderRadius.circular(7)),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: colorGray, width: 1.0),
                      //         borderRadius: BorderRadius.circular(7),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                      //   child: Text(
                      //     "CreditCard Expiry Date",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      //   child: TextField(
                      //     controller: addEmployeeController.creditCardExpDate,
                      //     style: const TextStyle(
                      //         height: 1.7, fontSize: 18, color: Colors.black),
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       hintText: 'Enter Expiry date',
                      //       fillColor: colorScreenBg,
                      //       filled: true,
                      //       isDense: true,
                      //       contentPadding: const EdgeInsets.only(
                      //           left: 12, top: 6, bottom: 6),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.grey, width: 1.0),
                      //           borderRadius: BorderRadius.circular(7)),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: colorGray, width: 1.0),
                      //         borderRadius: BorderRadius.circular(7),
                      //       ),
                      //     ),
                      //     onTap: () async {
                      //       DateTime? pickedDate = await showDatePicker(
                      //           context: context,
                      //           initialDate: DateTime.now(),
                      //           firstDate: DateTime(
                      //               2000), //DateTime.now() - not to allow to choose before today.
                      //           lastDate: DateTime(2101));
                      //
                      //       if (pickedDate != null) {
                      //         print(
                      //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      //         String formattedDate =
                      //             DateFormat('MM/yy').format(pickedDate);
                      //         print(
                      //             formattedDate); //formatted date output using intl package =>  2021-03-16
                      //         //you can implement different kind of Date Format here according to your requirement
                      //
                      //         setState(() {
                      //           addEmployeeController.creditCardExpDate.text =
                      //               formattedDate; //set output date to TextField value.
                      //         });
                      //       } else {
                      //         print("Date is not selected");
                      //       }
                      //     },
                      //   ),
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                      //   child: Text(
                      //     "Security Code",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      //   child: TextField(
                      //     controller: addEmployeeController.securityCode,
                      //     keyboardType: TextInputType.number,
                      //     style: const TextStyle(
                      //         height: 1.7, fontSize: 18, color: Colors.black),
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       hintText: 'Enter Security Code',
                      //       fillColor: colorScreenBg,
                      //       filled: true,
                      //       isDense: true,
                      //       contentPadding: const EdgeInsets.only(
                      //           left: 12, top: 6, bottom: 6),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.grey, width: 1.0),
                      //           borderRadius: BorderRadius.circular(7)),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: colorGray, width: 1.0),
                      //         borderRadius: BorderRadius.circular(7),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Department",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                      DropdownBelow(
                          itemWidth: MediaQuery.of(context).size.width - 30,
                          itemTextstyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          boxTextstyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
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
                                fontSize: 18,
                                color: selectedDepartment ==
                                        "Test Estimate Section"
                                    ? Colors.black.withOpacity(0.60)
                                    : Colors.black),
                          ),
                          onChanged: onChangeDropdownBoxSize,
                          items: departmentListItems),

                      // SizedBox(
                      //   height: 40,
                      //   child: TextField(
                      //     style: const TextStyle(
                      //         fontSize: 18, color: Colors.black),
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       suffixIcon: Align(
                      //         widthFactor: 1,
                      //         heightFactor: 1,
                      //         child: Icon(
                      //           Icons.keyboard_arrow_down_outlined,
                      //           color: appThemeGreen,
                      //         ),
                      //       ),
                      //       hintText: 'Account',
                      //       fillColor: colorScreenBg,
                      //       filled: true,
                      //       isDense: true,
                      //       contentPadding: const EdgeInsets.only(
                      //           left: 12, top: 6, bottom: 6),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.grey, width: 1.0),
                      //           borderRadius: BorderRadius.circular(7)),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: colorGray, width: 1.0),
                      //         borderRadius: BorderRadius.circular(7),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: GestureDetector(
                          onTap: () async {
                            debugPrint(addEmployeeController.employeeName.text +
                                addEmployeeController.email.text +
                                addEmployeeController.creditCardNo.text +
                                addEmployeeController.creditCardName.text +
                                addEmployeeController.creditCardExpDate.text +
                                addEmployeeController.securityCode.text +
                                addEmployeeController.department.text);

                            if (addEmployeeController
                                .employeeName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Oops!, Employee name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addEmployeeController
                                .email.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Email missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (!_isValidEmail(
                                addEmployeeController.email.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops, Invalid Email format!"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } /*else if (selectedDepartment == "Select Department") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Oops!, Please select Department from list."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }*/
                            // else if (addEmployeeController
                            //     .creditCardNo.text.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content:
                            //           Text("Oops!, CreditCard number missing."),
                            //       duration: Duration(seconds: 1),
                            //     ),
                            //   );
                            // } else if (addEmployeeController
                            //     .creditCardExpDate.text.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //           "Oops!, CreditCard expiryDate missing."),
                            //       duration: Duration(seconds: 1),
                            //     ),
                            //   );
                            // } else if (addEmployeeController
                            //     .securityCode.text.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text("Oops!, SecuryCode missing."),
                            //       duration: Duration(seconds: 1),
                            //     ),
                            //   );
                            // }
                            else {
                              await addEmployeeController
                                  .addEmployee(context)
                                  .then((value) {
                                setState(() {
                                  widget.callback();
                                  Navigator.pop(context);
                                });
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeGreen,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
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
      )),
    );
  }
}
