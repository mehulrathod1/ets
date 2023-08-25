import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../Controller/CompanyController/company_reset_usermane_comtroller.dart';
import '../../Models/CompanyModels/company_get_username_model.dart';
import '../../utils/Colors.dart';
import 'company_choose_username.dart';

class CompanyForgotUsername extends StatefulWidget {
  const CompanyForgotUsername({Key? key}) : super(key: key);

  @override
  State<CompanyForgotUsername> createState() => _CompanyForgotUsernameState();
}

class _CompanyForgotUsernameState extends State<CompanyForgotUsername> {
  late CompanyGetUsernameModel companyGetUsernameModel;
  CompanyResetUsernameController companyResetUsernameController =
      CompanyResetUsernameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Username Reset",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: colorScreenBg,
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/etslogo.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Username Reset",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: companyResetUsernameController.email,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: colorTextField,
                        suffixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: ImageIcon(
                            const AssetImage('assets/message.png'),
                            color: appThemeGreen,
                          ),
                        ),
                        hintText: 'Please Enter Email',
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGray, width: 1.0),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (companyResetUsernameController.email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please Enter Email"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        companyResetUsernameController
                            .companyGetUserName(context,
                                companyResetUsernameController.email.text)
                            .then((value) {
                          setState(() {
                            if (value != null) {
                              companyGetUsernameModel = value;
                              print(companyGetUsernameModel.message);
                              print(companyGetUsernameModel
                                  .data.list.first.username);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CompanyChooseUserName(
                                              email:
                                                  companyResetUsernameController
                                                      .email.text)));
                            } else {
                              print('companyGetUsernameModel.message');
                            }
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
                          'SUBMIT',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
