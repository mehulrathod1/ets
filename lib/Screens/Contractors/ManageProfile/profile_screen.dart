// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_profile_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_profile_details_model.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/edit_profile.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/profile_change_request.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/reset_password.dart';
import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
   Profile({Key? key,this.changeScreen}) : super(key: key);
  Function(int)? changeScreen;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  EmployeeProfileController employeeProfileController =
      EmployeeProfileController();
  EmployeeProfileDetailsModel? employeeProfileDetailsModel;
  bool loading = false;

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await employeeProfileController.getEmployeeProfile(context).then((value) {
      setState(() {
        if (value != null) {
          employeeProfileDetailsModel = value;
          loading = false;
        } else {
          loading = false;
        }
      });
    });
  }

  Future pickImage({bool gallery = true}) async {
    try {
      final image = await ImagePicker().pickImage(
          source: gallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      File imageFile = File(image.path);
      Uint8List imageBytes = await imageFile.readAsBytes();
      String base64string = base64.encode(imageBytes);
      await employeeProfileController.editProfilePicture(context, base64string);
      await employeeProfileController.getEmployeeProfile(context).then((value) {
        setState(() {
          if (value != null) {
            employeeProfileDetailsModel = value;
            Timer(const Duration(seconds: 3), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeDashboard(currentTableSelected: 0,)));
            });
          }
        });
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 150,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await pickImage(gallery: true);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: appThemeGreen,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Center(
                                          child: Text(
                                            'Pick Image from Gallery',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await pickImage(gallery: false);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: appThemeBlue,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Center(
                                          child: Text(
                                            'Pick Image from Camera',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          });
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: employeeProfileDetailsModel!
                                .data.profileImg.isEmpty
                            ? const CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage('assets/man.jpeg'),
                              )
                            : CachedNetworkImage(
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageUrl: employeeProfileDetailsModel!
                                    .data.profileImg,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Text(
                  employeeProfileDetailsModel!.data.employeeName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    employeeProfileDetailsModel!.data.email,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 18.0, left: 8, right: 8, bottom: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.employeeName,
                                style: TextStyle(
                                    fontSize: 18, color: colorTextGray),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Email: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.email,
                                style: TextStyle(
                                    fontSize: 18, color: colorTextGray),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Company Name: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.companyName,
                                style: TextStyle(
                                    fontSize: 18, color: colorTextGray),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Department: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!
                                    .data.departmentName,
                                style: TextStyle(
                                    fontSize: 18, color: colorTextGray),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            userName:
                                employeeProfileDetailsModel!.data.username,
                            employeeName:
                                employeeProfileDetailsModel!.data.employeeName,
                            employeeEmail:
                                employeeProfileDetailsModel!.data.email,
                            employeeProfilePic:
                                employeeProfileDetailsModel!.data.profileImg,
                            companyName:
                                employeeProfileDetailsModel!.data.companyName,
                            departmentName: employeeProfileDetailsModel!
                                .data.departmentName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: appThemeGreen,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Edit Info',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeBlue,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProfileChangeRequest()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Request Change Profile',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                )
              ],
            ),
    );
  }
}
