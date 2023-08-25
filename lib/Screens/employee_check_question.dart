import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../Controller/CompanyController/company_reset_usermane_comtroller.dart';
import '../Models/CompanyModels/company_get_username_model.dart';
import '../utils/Colors.dart';

class EmployeeCheckQuestion extends StatefulWidget {
  EmployeeCheckQuestion(
      {required this.email,
      required this.questionId,
      required this.question,
      Key? key})
      : super(key: key);

  String email;
  String questionId;
  String question;
  @override
  State<EmployeeCheckQuestion> createState() => _EmployeeCheckQuestionState();
}

class _EmployeeCheckQuestionState extends State<EmployeeCheckQuestion> {
  late CompanyGetUsernameModel companyGetUsernameModel;
  CompanyResetUsernameController companyResetUsernameController =
      CompanyResetUsernameController();

  @override
  void initState() {
// TODO: implement initState

    print(widget.email);
    print(widget.questionId);
    print(widget.question);
    companyResetUsernameController.email.text = widget.email;
    companyResetUsernameController.question.text = widget.question;
    companyResetUsernameController.questionId.text = widget.questionId;
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
          child: Column(
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
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                child: Text(
                  companyResetUsernameController.question.text,
                  textAlign:
                      TextAlign.start, // Align text inside to start (left)
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: companyResetUsernameController.answer,
                    style: const TextStyle(
                        height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Answer',
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
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print(companyResetUsernameController.answer.text);
                    if (companyResetUsernameController.answer.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Enter Email"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      companyResetUsernameController
                          .employeeCheckQuestion(context)
                          .then((value) {
                        setState(() {});
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
    );
  }
}
