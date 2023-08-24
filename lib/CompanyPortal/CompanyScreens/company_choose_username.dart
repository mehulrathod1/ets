import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../Controller/CompanyController/company_reset_usermane_comtroller.dart';
import '../../Models/CompanyModels/company_get_username_model.dart';
import '../../utils/Colors.dart';
import 'company_check_answer.dart';

class CompanyChooseUserName extends StatefulWidget {
  CompanyChooseUserName({required this.email, Key? key}) : super(key: key);

  String email;

  @override
  State<CompanyChooseUserName> createState() => _CompanyChooseUserNameState();
}

class _CompanyChooseUserNameState extends State<CompanyChooseUserName> {
  String selectedUserName = "Select UserName";

  late CompanyGetUsernameModel companyGetUsernameModel;
  CompanyResetUsernameController companyResetUsernameController =
      CompanyResetUsernameController();
  List<DropdownMenuItem<Object?>> userNameList = [];

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      // companyQuestionController.questionId.text = selectedTest['id'];
      selectedUserName = selectedTest['username'];
      // debugPrint(selectedTest['qtn']);
      // debugPrint(selectedTest['id']);
    });
  }

  List<DropdownMenuItem<Object?>> buildTaskSizeListItems(xyz) {
    List<DropdownMenuItem<Object?>> items = [];
    items.clear();
    for (var i in xyz) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['username'],
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () async {
      await companyResetUsernameController
          .companyGetUserNameList(context, widget.email)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      userNameList = buildTaskSizeListItems(value);
                    }),
                  }
                else
                  {
                    setState(() {
                      userNameList.clear();
                    }),
                  }
              });
    });
// TODO: implement initState
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
                  child: DropdownBelow(
                      itemWidth: MediaQuery.of(context).size.width - 30,
                      itemTextstyle:
                          const TextStyle(fontSize: 18, color: Colors.black),
                      boxTextstyle:
                          const TextStyle(fontSize: 18, color: Colors.black),
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
                        selectedUserName,
                        style: TextStyle(
                            fontSize: 18,
                            color: selectedUserName == "Select UserName"
                                ? Colors.black.withOpacity(0.60)
                                : Colors.black),
                      ),
                      onChanged: onChangeDropdownBoxSize,
                      items: userNameList),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (selectedUserName == 'Select UserName') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Username required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        // companyResetUsernameController
                        //     .companyGetQuestionForUserName(
                        //         context, widget.email);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompanyCheckQuestion(
                                    email: companyResetUsernameController
                                        .email.text)));
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
