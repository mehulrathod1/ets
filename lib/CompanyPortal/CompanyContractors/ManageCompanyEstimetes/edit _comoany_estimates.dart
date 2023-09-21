//EditCompanyEstimates

import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/CompanyController/company_add_estimate_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_edit_estimate_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ManageCompanyOrder/add_company_order.dart';

class EditCompanyEstimates extends StatefulWidget {
  EditCompanyEstimates(
      {
        required this.id,
        required this.contactId,
        required this.estimateName,
        required this.estimateDescription,
        required this.dueDate,
        required this.amount,
        required this.markup,
        required this.tax,
        required this.callback,
        Key? key})
      : super(key: key);
  String id;
  String contactId;
  String estimateName;
  String estimateDescription;
  String dueDate;
  String amount;
  String markup;
  String tax;
  final VoidCallback callback;

  @override
  State<EditCompanyEstimates> createState() => _EditCompanyEstimatesState();
}

class _EditCompanyEstimatesState extends State<EditCompanyEstimates> {
  /*EmployeeEditEstimateController editEstimateController =
  EmployeeEditEstimateController();*/
  CompanyEditEstimateController companyEstimateController =
  CompanyEditEstimateController();
  CompanyAddEstimateController addEstimateController = CompanyAddEstimateController();
  List<DropdownMenuItem<Object?>> contactListItems = [];
  String selectedContact = "Select contact";
  String? profilePic;
  bool loading = false;
  List<EmployeeListData> employeeListItems = [];
  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      companyEstimateController.contactId.text = selectedTest['id'];
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
    getProfilePic();
    Future.delayed(const Duration(microseconds: 0), () {
      addEstimateController
          .companyGetContactListForEstimate(context)
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

      addEstimateController.getEmployeeListForCompany(context).then((value) => {
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
    if (widget.markup.isEmpty) {
      widget.markup = '0';
    }
    if (widget.tax.isEmpty) {
      widget.tax = '0';
    }

    companyEstimateController.contactId.text = widget.contactId;
    companyEstimateController.estimateName.text = widget.estimateName;
    companyEstimateController.estimateDescription.text =
        widget.estimateDescription;
    companyEstimateController.dueDate.text = widget.dueDate;
    companyEstimateController.amount.text = widget.amount;
    companyEstimateController.markup.text = widget.markup;
    companyEstimateController.tax.text = widget.tax;
    super.initState();
  }

  Future<void> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pic = prefs.getString('profilePic');
    if (pic != null) {
      setState(() {
        profilePic = pic;
      });
    }
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
          child: Text("Edit Estimate",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: /*profilePic!.isEmpty
                ?*/ CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/man.jpeg'),
            )
               /* : CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(profilePic!),*/
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
                              controller: companyEstimateController.estimateName,
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
                              companyEstimateController.estimateDescription,
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
                              controller: companyEstimateController.dueDate,
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
                              controller: companyEstimateController.amount,
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
                              "Markup(%, If there is no markup then add 0)",
                              style: TextStyle(height: 1.7, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: companyEstimateController.markup,
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
                              "Tax(%, If there is no tax then add 0)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: companyEstimateController.tax,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  height: 1.7, fontSize: 18, color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Add tax',
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
                                if (selectedContact.isEmpty ||
                                    companyEstimateController.contactId.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Oops!, Please select contact from list."),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else if (companyEstimateController
                                    .estimateName.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Oops!,Estimate name missing."),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else if (companyEstimateController
                                    .estimateDescription.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Oops!,Estimate Description missing."),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else if (companyEstimateController
                                    .dueDate.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Oops!,Deu Date missing."),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else if (companyEstimateController
                                    .amount.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Oops!,amount missing."),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else {
                                  companyEstimateController
                                      .editEstimate(context, widget.id)
                                      .then((value) {
                                    setState(() {
                                      widget.callback();
                                      Navigator.pop(context);
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
