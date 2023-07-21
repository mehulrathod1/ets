import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../Controller/CompanyController/company_add_note_controller.dart';
import '../../../Models/CompanyModels/compay_add_note_model.dart';
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

class AddCompanyNote extends StatefulWidget {
  AddCompanyNote({required this.callback, Key? key}) : super(key: key);
  final VoidCallback callback;

  @override
  State<AddCompanyNote> createState() => _AddCompanyNoteState();
}

class _AddCompanyNoteState extends State<AddCompanyNote> {
  bool termsandcond = false;
  CompanyAddNoteController addNoteController = CompanyAddNoteController();
  late CompanyAddNoteModel companyAddNoteModel;

  List<EmployeeListData> employeeListItems = [];
  String selectedEmployeeListId = "";
  List<EmployeeListData> selectedEmployeeList = [];
  bool loading = false;

  List<DropdownMenuItem<Object?>> noteListItems = [];
  String selectedEstimate = "Select Estimate";
  void showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: employeeListItems
              .map((e) => MultiSelectItem(e, e.employeeName!))
              .toList(),
          initialValue: selectedEmployeeList,
          onConfirm: (values) {
            setState(() {
              selectedEmployeeListId = "";
              addNoteController.employeeList.clear();
              selectedEmployeeList = values;
              for (int i = 0; i < selectedEmployeeList.length; i++) {
                addNoteController.employeeList.text =
                    addNoteController.employeeList.text +
                        selectedEmployeeList[i].employeeName!;
                selectedEmployeeListId =
                    selectedEmployeeListId + selectedEmployeeList[i].id!;
                if (i != selectedEmployeeList.length - 1) {
                  addNoteController.employeeList.text =
                      "${addNoteController.employeeList.text}, ";
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
      addNoteController.estimateId.text = selectedTest['estimate_id'];
      selectedEstimate = selectedTest['estimate_name'];
      debugPrint(addNoteController.estimateId.text);
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
    Future.delayed(const Duration(microseconds: 0), () async {
      addNoteController.noteStatus.text = "0";
      await addNoteController
          .getEstimateNoteListForCompany(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      noteListItems = buildTaskSizeListItems(value);
                    }),
                  }
                else
                  {
                    setState(() {
                      noteListItems.clear();
                    }),
                  }
              });

      await addNoteController
          .getEmployeeListForCompany(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      for (int i = 0; i < value.length; i++) {
                        employeeListItems.add(EmployeeListData(
                            id: value[i]["id"],
                            employeeName: value[i]["employee_name"],
                            email: value[i]["email"]));
                      }
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
// TODO: implement initState
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
          child: Text("Add Notes",
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
                                value: termsandcond,
                                fillColor:
                                    MaterialStateProperty.all(appThemeGreen),
                                onChanged: (v) {
                                  setState(() {
                                    termsandcond = v!;
                                    if (termsandcond == true) {
                                      addNoteController.noteStatus.text = '1';
                                    } else {
                                      addNoteController.noteStatus.text = '0';
                                    }
                                    debugPrint(
                                        addNoteController.noteStatus.text);
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
                          controller: addNoteController.noteName,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter task name',
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
                            controller: addNoteController.noteDescription,
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
                          controller: addNoteController.employeeList,
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
                            hintText: 'Test, Test1, Test2',
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
                            addNoteController
                                .addCompanyNote(context,
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
