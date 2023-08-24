import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../Controller/CompanyController/company_reset_usermane_comtroller.dart';
import '../../Models/CompanyModels/company_get_username_model.dart';
import '../../utils/Colors.dart';

class CompanyCheckQuestion extends StatefulWidget {
  CompanyCheckQuestion({required this.email, Key? key}) : super(key: key);
  String email;
  @override
  State<CompanyCheckQuestion> createState() => _CompanyCheckQuestionState();
}

class _CompanyCheckQuestionState extends State<CompanyCheckQuestion> {
  String selectedUserName = "Select UserName";

  late CompanyGetUsernameModel companyGetUsernameModel;
  CompanyResetUsernameController companyResetUsernameController =
      CompanyResetUsernameController();

  @override
  void initState() {
// TODO: implement initState
    companyResetUsernameController.companyGetQuestionForUserName(
        context, widget.email);

    super.initState();
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
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
                  "Security Question",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Order Name",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(
                        height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter order name',
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
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
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
