// ignore_for_file: must_be_immutable

import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_note_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditNote extends StatefulWidget {
  EditNote(
      {required this.id,
      required this.noteName,
      required this.noteDescription,
      required this.noteStatus,
      required this.estimateId,
      Key? key})
      : super(key: key);
  String id;
  String noteName;
  String noteDescription;
  String noteStatus;
  String estimateId;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  EmployeeNoteController employeeNoteController = EmployeeNoteController();
  bool termsandcond = false;

  List<DropdownMenuItem<Object?>> orderListItems = [];
  String selectEstimate = "Select Estimate";

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      selectEstimate = selectedTest['estimate_name'];
      employeeNoteController.estimateId.text = selectedTest['estimate_id'];
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
    termsandcond = widget.noteStatus == "1" ? true : false;
    employeeNoteController.noteName.text = widget.noteName;
    employeeNoteController.noteDescription.text = widget.noteDescription;

    Future.delayed(const Duration(microseconds: 0), () async {
      await employeeNoteController
          .getEmployeeEstimate(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      orderListItems = buildTaskSizeListItems(value);
                      for (int i = 0; i < value.length; i++) {
                        if (value[i]["estimate_id"] == widget.estimateId) {
                          employeeNoteController.estimateId.text =
                              value[i]["estimate_id"];
                          selectEstimate = value[i]["estimate_name"];
                        }
                      }
                    }),
                  }
                else
                  {
                    setState(() {
                      orderListItems.clear();
                    }),
                  }
              });
    });

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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: colorScreenBg,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Note For",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                DropdownBelow(
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
                      selectEstimate,
                      style: TextStyle(
                          fontSize: 18,
                          color: selectEstimate == "Select Estimate"
                              ? Colors.black.withOpacity(0.60)
                              : Colors.black),
                    ),
                    onChanged: onChangeDropdownBoxSize,
                    items: orderListItems),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          controller: employeeNoteController.noteName,
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
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            controller: employeeNoteController.noteDescription,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: InkWell(
                          onTap: () async {
                            if (employeeNoteController.noteName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Note name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (employeeNoteController
                                .noteDescription.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Oops!, Note description missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              await employeeNoteController.editNotes(context,
                                  markAsComplete: termsandcond, id: widget.id);
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
