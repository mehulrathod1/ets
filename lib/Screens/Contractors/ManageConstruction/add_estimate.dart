import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../Controller/EmployeeController/employeee_add_estimate_controller.dart';

class AddEstimate extends StatefulWidget {
  const AddEstimate({Key? key}) : super(key: key);

  @override
  State<AddEstimate> createState() => _AddEstimateState();
}

class _AddEstimateState extends State<AddEstimate> {
  EmployeeAddEstimateController addEstimateController =
      EmployeeAddEstimateController();

  List<DropdownMenuItem<Object?>> contactListItems = [];
  String selectedContact = "Select contact";

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      addEstimateController.contactId.text = selectedTest['id'];
      selectedContact = selectedTest['first_name'];
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
            i['first_name'],
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
      await addEstimateController
          .getContactListForEstimate(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      contactListItems = buildTaskSizeListItems(value);
                    }),
                  }
                else
                  {
                    setState(() {
                      contactListItems.clear();
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
          child: Text("Add Estimate",
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
                            "Billed For",
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
                              selectedContact,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: selectedContact == "Select contact"
                                      ? Colors.black.withOpacity(0.60)
                                      : Colors.black),
                            ),
                            onChanged: onChangeDropdownBoxSize,
                            items: contactListItems),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text(
                            "Estimate Name",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEstimateController.estimateName,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter Estimate name',
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
                            "Estimate Description",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller:
                                addEstimateController.estimateDescription,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter estimate description',
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
                            "Due Date",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEstimateController.dueDate,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText:
                                  'Testing the estimate section description',
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
                                  addEstimateController.dueDate.text =
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
                            'Amount',
                            style: TextStyle(height: 1.7, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEstimateController.amount,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Add Amount',
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
                            "Markup(%)",
                            style: TextStyle(height: 1.7, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEstimateController.markup,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Add Markup',
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
                            "Tax(%)",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: addEstimateController.tax,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Add tex',
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
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              await addEstimateController.addEstimate(context);
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
                              ),
                            ),
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
