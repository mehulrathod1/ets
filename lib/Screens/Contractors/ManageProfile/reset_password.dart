import 'package:etsemployee/Controller/EmployeeController/employee_reset_password_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({required this.employeeProfilePic, Key? key}) : super(key: key);
  String employeeProfilePic;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  EmployeeResetPasswordController resetPasswordController =
      EmployeeResetPasswordController();
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
          child: Text("Reset Password",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                  child: Text(
                    "Previous Password",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(
                        height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    controller: resetPasswordController.oldPassword,
                    decoration: InputDecoration(
                      hintText: 'Enter current password',
                      fillColor: colorScreenBg,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorGray, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                  child: Text(
                    "New Password",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(
                        height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    controller: resetPasswordController.newPassword,
                    decoration: InputDecoration(
                      hintText: 'Enter new password',
                      fillColor: colorScreenBg,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorGray, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(
                        height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    controller: resetPasswordController.confirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Enter Confirm Password',
                      fillColor: colorScreenBg,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorGray, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: InkWell(
                    onTap: () async {
                      if (resetPasswordController.oldPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Old password missing!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (resetPasswordController
                          .newPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, New password missing!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (resetPasswordController
                          .confirmPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Confirm password missing!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (resetPasswordController.newPassword.text !=
                          resetPasswordController.confirmPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Oops!, New password and confirm password not match!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        await resetPasswordController.resetPassword(context);
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
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }
}
