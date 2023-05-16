// ignore_for_file: must_be_immutable

import 'package:etsemployee/Controller/EmployeeController/employee_profile_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {required this.userName,
      required this.employeeName,
      required this.employeeEmail,
      required this.employeeProfilePic,
      required this.companyName,
      required this.departmentName,
      Key? key})
      : super(key: key);
  String userName;
  String employeeName;
  String employeeEmail;
  String employeeProfilePic;
  String companyName;
  String departmentName;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EmployeeProfileController employeeProfileController =
      EmployeeProfileController();

  @override
  void initState() {
    employeeProfileController.userName.text = widget.userName;
    employeeProfileController.employeeName.text = widget.employeeName;
    employeeProfileController.employeeEmail.text = widget.employeeEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: colorScreenBg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorScreenBg,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title: const Center(
            child: Text("Edit Details",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: widget.employeeProfilePic.isEmpty
                  ? const CircleAvatar(
                      backgroundImage: AssetImage('assets/man.jpeg'),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(widget.employeeProfilePic),
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                //     child: Center(
                //       child: widget.employeeProfilePic.isEmpty
                //           ? const CircleAvatar(
                //               radius: 80,
                //               backgroundImage: AssetImage('assets/man.jpeg'),
                //             )
                //           : CircleAvatar(
                //               radius: 80,
                //               backgroundImage: NetworkImage(widget.employeeProfilePic),
                //             ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                        child: Text(
                          "Employee Name",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          controller: employeeProfileController.employeeName,
                          decoration: InputDecoration(
                            hintText: 'Test Edit 1',
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
                        padding:
                            EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                        child: Text(
                          "Employee Email",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          controller: employeeProfileController.employeeEmail,
                          decoration: InputDecoration(
                            hintText: 'crazycoder09@gmail.com',
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
                        padding:
                            EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                        child: Text(
                          "Company Name",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          readOnly: true,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: widget.companyName,
                            fillColor: colorLightGray,
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
                        padding:
                            EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                        child: Text(
                          "Department",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          readOnly: true,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: widget.departmentName,
                            fillColor: colorLightGray,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: InkWell(
                          onTap: () async {
                            if (employeeProfileController
                                .employeeName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Oops!, Employee name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (employeeProfileController
                                .employeeEmail.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Oops!, Employee email missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              await employeeProfileController
                                  .editProfileDetails(context);
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
                                'Update',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
        ),
      ),
    );
  }
}
