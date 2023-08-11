import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import '../../../Controller/EmployeeController/employee_add_invoice_for_contact.dart';
import '../../../Controller/EmployeeController/employee_edit_contact_invoice_controller.dart';
import '../../../utils/Colors.dart';

class EmployeeEditContactInvoice extends StatefulWidget {
  EmployeeEditContactInvoice(
      {Key? key,
      required this.callback,
      required this.id,
      required this.contactId,
      required this.description,
      required this.amount,
      required this.invoiceDate,
      required this.signatureName,
      required this.signatureUrl})
      : super(key: key);

  String id;
  String contactId;
  String description;
  String amount;
  String invoiceDate;
  String signatureName;
  String signatureUrl;
  final VoidCallback callback;

  @override
  State<EmployeeEditContactInvoice> createState() =>
      _EmployeeEditContactInvoiceState();
}

class _EmployeeEditContactInvoiceState
    extends State<EmployeeEditContactInvoice> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  String signaturePath = "";
  String base64ImagePath = "";
  String? profilePic;

  List<DropdownMenuItem<Object?>> contactListItems = [];
  String selectContact = "Select Contact";

  EmployeeEditContactInvoiceController editContactInvoiceController =
      EmployeeEditContactInvoiceController();

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      String firstName = selectedTest['first_name'];
      String lastName = selectedTest['last_name'];
      selectContact = '$firstName $lastName';
      editContactInvoiceController.contactId.text = selectedTest['id'];
    });
  }

  List<DropdownMenuItem<Object?>> buildTaskSizeListItems(xyz) {
    List<DropdownMenuItem<Object?>> items = [];
    items.clear();
    for (var i in xyz) {
      String fullName =
          '${i['first_name']} ${i['last_name']}'; // Merge first name and last name

      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            fullName,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
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
  void initState() {
    getProfilePic();
    editContactInvoiceController.id.text = widget.id;
    editContactInvoiceController.contactId.text = widget.contactId;
    editContactInvoiceController.description.text = widget.description;
    editContactInvoiceController.amount.text = widget.amount;
    editContactInvoiceController.invoiceDate.text = widget.invoiceDate;
    editContactInvoiceController.signName.text = widget.signatureName;

    Future.delayed(const Duration(microseconds: 0), () async {
      await editContactInvoiceController.getContact(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  contactListItems = buildTaskSizeListItems(value);
                  for (int i = 0; i < value.length; i++) {
                    if (value[i]["id"] == widget.contactId) {
                      editContactInvoiceController.contactId.text =
                          value[i]["id"];
                      String firstName = value[i]['first_name'];
                      String lastName = value[i]['last_name'];
                      selectContact = '$firstName $lastName';
                    }
                  }
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

    getPermission();
    super.initState();
  }

  void getPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
  }

  void _handleClearButtonPressed() async {
    signatureGlobalKey.currentState!.clear();
    File(signaturePath).delete();
    setState(() {
      base64ImagePath = '';
    });
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    Uint8List unit = bytes!.buffer.asUint8List();
    base64ImagePath = base64.encode(unit);

    print(base64ImagePath);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Signature Submitted Successfully"),
        duration: Duration(seconds: 1),
      ),
    );
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
          child: Text("Edit Invoice For Contact",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: profilePic!.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(profilePic!),
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
                            "Billed For ",
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
                              selectContact,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: selectContact == "Select Contact"
                                      ? Colors.black.withOpacity(0.60)
                                      : Colors.black),
                            ),
                            onChanged: onChangeDropdownBoxSize,
                            items: contactListItems),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                          child: Text(
                            "Description",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller:
                                editContactInvoiceController.description,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
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
                            "Amount",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: editContactInvoiceController.amount,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
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
                            "Invoice Date",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller:
                                editContactInvoiceController.invoiceDate,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
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
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  editContactInvoiceController
                                          .invoiceDate.text =
                                      formattedDate; //set output date to TextField value.
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
                            "E-Signature",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Sign in the canvas below and save your signature as an image!",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: editContactInvoiceController.signName,
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
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
                        SizedBox(height: 8),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: colorGray),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SfSignaturePad(
                                key: signatureGlobalKey,
                                backgroundColor: Colors.white,
                                strokeColor: Colors.black,
                                minimumStrokeWidth: 1.0,
                                maximumStrokeWidth: 4.0),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: colorGray),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image(
                              image: NetworkImage(widget.signatureUrl),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16.0, right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    _handleClearButtonPressed();
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: colorred),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Clear Signature",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16.0, right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    _handleSaveButtonPressed();
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: appThemeGreen),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text("Submit Signature",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (selectContact == "Select Contact") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Oops!, Please select contact from list."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editContactInvoiceController
                                  .description.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Oops!, Estimate description missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editContactInvoiceController
                                  .amount.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Oops!, amount missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editContactInvoiceController
                                  .invoiceDate.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, invoice Date missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editContactInvoiceController
                                  .signName.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, Signature Name missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                await editContactInvoiceController
                                    .editContactInvoice(context,
                                        signature: base64ImagePath)
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
