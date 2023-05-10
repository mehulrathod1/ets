import 'package:etsemployee/Controller/CompanyController/company_change_password_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompanyChangePassword extends StatefulWidget {
  const CompanyChangePassword({Key? key}) : super(key: key);

  @override
  State<CompanyChangePassword> createState() => _CompanyChangePasswordState();
}

class _CompanyChangePasswordState extends State<CompanyChangePassword> {
  bool oldPassword = true;
  bool newPassword = true;
  bool confirmPassword = true;

  CompanyChangePasswordController changePasswordController = CompanyChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("reset Password", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
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
                    obscureText: oldPassword,
                    controller: changePasswordController.oldPassword,
                    style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (oldPassword) {
                              oldPassword = false;
                            } else {
                              oldPassword = true;
                            }
                          });
                        },
                        child: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            oldPassword == true ? Icons.remove_red_eye : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hintText: 'Enter current password',
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
                    obscureText: newPassword,
                    controller: changePasswordController.newPassword,
                    style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (newPassword) {
                              newPassword = false;
                            } else {
                              newPassword = true;
                            }
                          });
                        },
                        child: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            newPassword == true ? Icons.remove_red_eye : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hintText: 'Enter new password',
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
                    controller: changePasswordController.confirmPassword,
                    obscureText: confirmPassword,
                    style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (confirmPassword) {
                              confirmPassword = false;
                            } else {
                              confirmPassword = true;
                            }
                          });
                        },
                        child: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            confirmPassword == true ? Icons.remove_red_eye : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hintText: 'Enter Confirm Password',
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (changePasswordController.oldPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Old password missing!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (changePasswordController.newPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, New password missing!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (changePasswordController.confirmPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Confirm password missing!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (changePasswordController.newPassword.text != changePasswordController.confirmPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, New password and confirm password not match!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        await changePasswordController.companyChangePassword(context);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
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
