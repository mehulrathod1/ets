// ignore_for_file: must_be_immutable

import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/CompanyController/company_edit_note_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../Controller/CompanyController/company_edit_note_controller.dart';
import '../../../Network/api_constant.dart';

class EmployeeListData {
  String? id;
  String? employeeName;
  String? email;

  EmployeeListData({
    this.id,
    this.employeeName,
    this.email,
  });
}

class EditCompanyNote extends StatefulWidget {
  EditCompanyNote(
      {required this.callback,
      required this.id,
      required this.noteStatus,
      required this.noteName,
      required this.noteDescription,
      required this.employeeList,
      required this.estimateId,
      Key? key})
      : super(key: key);

  String id;
  String noteStatus;
  String noteName;
  String noteDescription;
  String employeeList;
  String estimateId;
  final VoidCallback callback;

  @override
  State<EditCompanyNote> createState() => _EditCompanyNoteState();
}

class _EditCompanyNoteState extends State<EditCompanyNote> {
  bool termsAndCond = false;
  CompanyEditNoteController editNoteController = CompanyEditNoteController();
  List<int> resultList = [];
  List<EmployeeListData> employeeListItems = [];
  String selectedEmployeeListId = "";
  List<EmployeeListData> selectedEmployeeList = [];
  bool loading = false;
  List<DropdownMenuItem<Object?>> noteListItems = [];
  String selectedEstimate = "Select Estimate";
  void showMultiSelect(BuildContext context) async {
    var v = employeeListItems.map((e) => MultiSelectItem(
          e,
          e.employeeName!,
        ));

    print(employeeListItems[0]);
    print(selectedEmployeeList.length);
    // employeeListItems = selectedEmployeeList;
    print(employeeListItems.length);
    List<EmployeeListData> initialSelectedEmployees = [];

    for (int index = 0; index < employeeListItems.length; index++) {
      for (int i = 0; i < selectedEmployeeList.length; i++) {
        if (selectedEmployeeList[i].id == employeeListItems[index].id) {
          initialSelectedEmployees.add(employeeListItems[index]);
        }
      }
    }

    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: v.toList(),
          initialValue: initialSelectedEmployees,
          onConfirm: (values) {
            setState(() {
              selectedEmployeeListId = "";
              editNoteController.employeeList.clear();
              selectedEmployeeList = values;
              for (int i = 0; i < selectedEmployeeList.length; i++) {
                editNoteController.employeeList.text =
                    editNoteController.employeeList.text +
                        selectedEmployeeList[i].employeeName!;
                selectedEmployeeListId =
                    selectedEmployeeListId + selectedEmployeeList[i].id!;
                if (i != selectedEmployeeList.length - 1) {
                  editNoteController.employeeList.text =
                      "${editNoteController.employeeList.text}, ";
                  selectedEmployeeListId = "$selectedEmployeeListId,";
                }
              }
            });
          },
        );
      },
    );
  }

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      editNoteController.estimateId.text = selectedTest['estimate_id'];
      selectedEstimate = selectedTest['estimate_name'];
      debugPrint(editNoteController.estimateId.text);
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
            i['estimate_name'],
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    editNoteController.noteStatus.text = widget.noteStatus;
    editNoteController.noteDescription.text = widget.noteDescription;
    editNoteController.noteName.text = widget.noteName;
    print(widget.employeeList);

    if (widget.employeeList.isNotEmpty) {
      resultList = widget.employeeList
          .split(',')
          .map((item) => int.parse(item))
          .toList();
    }
    print(widget.employeeList);
    selectedEmployeeListId = widget.employeeList;
    print(selectedEmployeeListId);
    List<String> c;

    Future.delayed(const Duration(microseconds: 0), () async {
      await editNoteController
          .getEstimateNoteListForCompany(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      noteListItems = buildTaskSizeListItems(value);
                      for (int i = 0; i < value.length; i++) {
                        if (value[i]["estimate_id"] == widget.estimateId) {
                          editNoteController.estimateId.text =
                              value[i]["estimate_id"];
                          selectedEstimate = value[i]["estimate_name"];
                        }
                      }
                    }),
                  }
                else
                  {
                    setState(() {
                      noteListItems.clear();
                    }),
                  }
              });

      await editNoteController
          .getEmployeeListForCompany(context)
          .then((value) => {
                if (value != null)
                  {
                    print(resultList.toString()),
                    print(value.toString()),
                    c = resultList.map((id) {
                      var item = value.firstWhere(
                          (item) => item["id"] == id.toString(),
                          orElse: () =>
                              {"employee_name": "Not Found"})["employee_name"];
                      return item.toString();
                    }).toList(),
                    print(c.join(", ")),
                    editNoteController.employeeList.text = c.join(", "),
                    setState(() {
                      for (int i = 0; i < value.length; i++) {
                        employeeListItems.add(EmployeeListData(
                            id: value[i]["id"],
                            employeeName: value[i]["employee_name"],
                            email: value[i]["email"]));

                        for (int j = 0; j < resultList.length; j++) {
                          if (resultList[j].toString() == value[i]["id"]) {
                            selectedEmployeeList.add(EmployeeListData(
                                id: value[i]["id"],
                                employeeName: value[i]["employee_name"],
                                email: value[i]["email"]));

                            // if (j != resultList.length - 1) {
                            //   editNoteController.employeeList.text =
                            //       "${editNoteController.employeeList.text}, ";
                            //   selectedEmployeeListId =
                            //       "$selectedEmployeeListId,";
                            // }
                            // editNoteController.employeeList.text =
                            //     editNoteController.employeeList.text +
                            //         value[i]["employee_name"]!;
                            //
                            // selectedEmployeeListId =
                            //     selectedEmployeeListId + value[i]["id"]!;
                            //
                            // selectedEmployeeList.add(value[i]["employee_name"]);
                          }
                        }
                      }
                      print(editNoteController.employeeList.text);
                      print(selectedEmployeeListId);
                      loading = false;
                    }),
                  }
                else
                  {
                    setState(() {
                      employeeListItems.clear();
                      loading = false;
                    }),
                  }
              });
    });

    if (widget.noteStatus == '0') {
      termsAndCond = false;
    } else {
      termsAndCond = true;
    }
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
          child: Text("Edit Notes",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ApiConstant.profileImage.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(ApiConstant.profileImage),
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
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: colorScreenBg,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Task For",
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
                            selectedEstimate,
                            style: TextStyle(
                                fontSize: 18,
                                color: selectedEstimate == "Select Estimate"
                                    ? Colors.black.withOpacity(0.60)
                                    : Colors.black),
                          ),
                          onChanged: onChangeDropdownBoxSize,
                          items: noteListItems),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                                value: termsAndCond,
                                fillColor:
                                    MaterialStateProperty.all(appThemeGreen),
                                onChanged: (v) {
                                  setState(() {
                                    termsAndCond = v!;
                                    if (termsAndCond == true) {
                                      editNoteController.noteStatus.text = '1';
                                    } else {
                                      editNoteController.noteStatus.text = '0';
                                    }
                                  });
                                }),
                            const Text(
                              'Mark As Complete',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Note Name",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editNoteController.noteName,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter note name',
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
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Note Description",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: colorGray),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextField(
                            controller: editNoteController.noteDescription,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter description',
                              fillColor: colorScreenBg,
                              filled: true,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 12, top: 6, bottom: 6),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Employee List",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editNoteController.employeeList,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                              widthFactor: 1,
                              heightFactor: 1,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: appThemeGreen,
                              ),
                            ),
                            hintText: 'Select Employee',
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
                          onTap: () {
                            showMultiSelect(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            editNoteController
                                .editNote(context, widget.id,
                                    employeeId: selectedEmployeeListId)
                                .then((value) {
                              setState(() {
                                Navigator.pop(context);
                                widget.callback();
                              });
                            });
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
