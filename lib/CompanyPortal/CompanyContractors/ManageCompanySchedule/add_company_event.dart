import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../Controller/CompanyController/company_add_event_controller.dart';

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

class AddCompanyEvent extends StatefulWidget {
  const AddCompanyEvent({Key? key}) : super(key: key);

  @override
  State<AddCompanyEvent> createState() => _AddCompanyEventState();
}

class _AddCompanyEventState extends State<AddCompanyEvent> {
  CompanyAddEventController addEventController = CompanyAddEventController();

  List<EmployeeListData> employeeListItems = [];
  String selectedEmployeeListId = "";
  List<EmployeeListData> selectedEmployeeList = [];
  bool loading = false;

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
              addEventController.employeeList.clear();
              selectedEmployeeList = values;
              for (int i = 0; i < selectedEmployeeList.length; i++) {
                addEventController.employeeList.text =
                    addEventController.employeeList.text +
                        selectedEmployeeList[i].employeeName!;
                selectedEmployeeListId =
                    selectedEmployeeListId + selectedEmployeeList[i].id!;
                if (i != selectedEmployeeList.length - 1) {
                  addEventController.employeeList.text =
                      "${addEventController.employeeList.text}, ";
                  selectedEmployeeListId = "$selectedEmployeeListId,";
                }
              }
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () async {
      await addEventController
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
          child: Text("Add Event ",
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text(
                            "Event ID",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            readOnly: true,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: '1674464668',
                              fillColor: colorLightGray,
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
                            "Start Date",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEventController.evtStart,
                            //editing controller of this TextField
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: '12/31/1996',
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
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('MM/dd/yyyy').format(pickedDate);
                                setState(() {
                                  addEventController.evtStart.text =
                                      formattedDate;
                                });
                              } else {
                                debugPrint("Date is not selected");
                              }
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text(
                            "End Date",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEventController.evtEnd,
                            //editing controller of this TextField
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: '12/31/1996',
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
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('MM/dd/yyyy').format(pickedDate);
                                setState(() {
                                  addEventController.evtEnd.text =
                                      formattedDate;
                                });
                              } else {
                                debugPrint("Date is not selected");
                              }
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text(
                            "Event Name",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEventController.eventName,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter event name',
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
                            "Event Description",
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
                              controller: addEventController.eventDescription,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Event Description',
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
                              hintText: 'Select Employee ',
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
                              addEventController.addEvent(context,
                                  employeeId: selectedEmployeeListId);
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
        ),
      ),
    );
  }
}
