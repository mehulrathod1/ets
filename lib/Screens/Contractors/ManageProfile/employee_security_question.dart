import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';

import '../../../Controller/CompanyController/company_get_question_controller.dart';
import '../../../Controller/CompanyController/company_question_contolller.dart';
import '../../../Models/CompanyModels/company_get_question_model.dart';
import '../../../utils/Colors.dart';

class EmployeeSecurityQuestion extends StatefulWidget {
  EmployeeSecurityQuestion({required this.employeeProfilePic, Key? key})
      : super(key: key);
  String employeeProfilePic;

  @override
  State<EmployeeSecurityQuestion> createState() =>
      _EmployeeSecurityQuestionState();
}

class _EmployeeSecurityQuestionState extends State<EmployeeSecurityQuestion> {
  CompanyQuestionController companyQuestionController =
      CompanyQuestionController();
  List<DropdownMenuItem<Object?>> questionList = [];
  String selectedQuestion = "Select Question";
  bool loading = false;

  CompanyGetQuestionController companyGetQuestionController =
      CompanyGetQuestionController();
  CompanyGetQuestionModel? companyGetQuestionModel;

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      companyQuestionController.questionId.text = selectedTest['id'];
      selectedQuestion = selectedTest['qtn'];
      debugPrint(selectedTest['qtn']);
      debugPrint(selectedTest['id']);
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
            i['qtn'],
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  Future initialize(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await companyGetQuestionController
        .getEmployeeQuestion(context)
        .then((value) {
      setState(() {
        if (value != null) {
          companyGetQuestionModel = value;
          loading = false;
          print(companyGetQuestionModel!.data.qtnId);
          print(companyGetQuestionModel!.data.answer);

          Future.delayed(const Duration(microseconds: 0), () async {
            companyQuestionController.answer.text =
                companyGetQuestionModel!.data.answer;
            await companyQuestionController
                .getAllEmployeeSecurityQuestion(context)
                .then((value) => {
                      if (value != null)
                        {
                          setState(() {
                            questionList = buildTaskSizeListItems(value);
                            for (int i = 0; i < value.length; i++) {
                              if (value[i]["id"] ==
                                  companyGetQuestionModel!.data.qtnId) {
                                companyQuestionController.questionId.text =
                                    value[i]["id"];
                                selectedQuestion = value[i]["qtn"];
                              }
                            }
                          }),
                        }
                      else
                        {
                          setState(() {
                            questionList.clear();
                          }),
                        }
                    });
          });
        } else {
          loading = false;
        }
      });
    });
  }

  @override
  void initState() {
    initialize(context);
    // Future.delayed(const Duration(microseconds: 0), () async {
    //   await companyQuestionController
    //       .getAllEmployeeSecurityQuestion(context)
    //       .then((value) => {
    //             if (value != null)
    //               {
    //                 setState(() {
    //                   questionList = buildTaskSizeListItems(value);
    //                 }),
    //               }
    //             else
    //               {
    //                 setState(() {
    //                   questionList.clear();
    //                 }),
    //               }
    //           });
    // });
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
          child: Text("Security Question",
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
      body: loading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Update Security Question",
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
                            selectedQuestion,
                            style: TextStyle(
                                fontSize: 18,
                                color: selectedQuestion == "Select Question"
                                    ? Colors.black.withOpacity(0.60)
                                    : Colors.black),
                          ),
                          onChanged: onChangeDropdownBoxSize,
                          items: questionList),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                        child: Text(
                          "Answer",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: companyQuestionController.answer,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter answer',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: InkWell(
                          onTap: () async {
                            if (selectedQuestion == "Select Question") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Oops!, Please select question from list."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (companyQuestionController
                                .answer.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Answer missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              companyQuestionController
                                  .updateEmployeeQuestion(context);
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
                                'Submit',
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
    );
  }
}
