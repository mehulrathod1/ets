import 'package:etsemployee/Controller/EmployeeController/employee_profile_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_profile_details_model.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/edit_profile.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/profile_change_request.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/reset_password.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  EmployeeProfileController employeeProfileController = EmployeeProfileController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
/*      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Profile", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
            ),
          ),
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }),
      ),*/
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: employeeProfileDetailsModel!.data.profileImg.isEmpty
                          ? const CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage('assets/man.jpeg'),
                            )
                          : CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(employeeProfileDetailsModel!.data.profileImg),
                            ),
                    ),
                  ),
                ),
                Text(
                  employeeProfileDetailsModel!.data.companyName,
                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    employeeProfileDetailsModel!.data.email,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8, bottom: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: Colors.black), color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.employeeName,
                                style: TextStyle(fontSize: 18, color: colorTextGray),
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
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.email,
                                style: TextStyle(fontSize: 18, color: colorTextGray),
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
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.companyName,
                                style: TextStyle(fontSize: 18, color: colorTextGray),
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
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employeeProfileDetailsModel!.data.departmentName,
                                style: TextStyle(fontSize: 18, color: colorTextGray),
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
                            userName: employeeProfileDetailsModel!.data.username,
                            employeeName: employeeProfileDetailsModel!.data.employeeName,
                            employeeEmail: employeeProfileDetailsModel!.data.email,
                            employeeProfilePic: employeeProfileDetailsModel!.data.profileImg,
                          ),
                        ),
                      );
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Edit Info',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileChangeRequest()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
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
