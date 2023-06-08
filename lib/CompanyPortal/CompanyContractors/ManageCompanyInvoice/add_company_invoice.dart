import 'dart:convert';
import 'dart:io';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../Controller/CompanyController/company_add_invoice_controller.dart';
import '../../../Network/api_constant.dart';
import '../../../Controller/CompanyController/company_invoive_controller.dart';
import 'dart:ui' as ui;

class AddCompanyInvoice extends StatefulWidget {
  const AddCompanyInvoice({Key? key}) : super(key: key);

  @override
  State<AddCompanyInvoice> createState() => _AddCompanyInvoiceState();
}

class _AddCompanyInvoiceState extends State<AddCompanyInvoice> {
  bool termsandcond = false;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  CompanyInvoiceController invoiceController = CompanyInvoiceController();
  List<DropdownMenuItem<Object?>> invoiceForListItems = [];
  String selectedInvoice = "Select Estimate";
  String base64ImagePath = "";
  String signaturePath = "";
  CompanyAddInvoiceController addInvoiceController =
      CompanyAddInvoiceController();
  void getPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
  }

  void _handleClearButtonPressed() async {
    signatureGlobalKey.currentState!.clear();
    base64ImagePath = '';
    File(signaturePath).delete();
    setState(() {});
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    Uint8List unit = bytes!.buffer.asUint8List();
    base64ImagePath = base64.encode(unit);

    print(base64ImagePath);

    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return Scaffold(
    //         appBar: AppBar(),
    //         body: Center(
    //           child: Container(
    //             color: Colors.grey[300],
    //             child: Image.memory(bytes!.buffer.asUint8List()),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      selectedInvoice = selectedTest['estimate_name'];
      debugPrint(selectedTest['id']);
      addInvoiceController.invoiceForId.text = selectedTest['id'];

      addInvoiceController.estimateAmount.text = selectedTest['amount'];
      addInvoiceController.description.text =
          selectedTest['estimate_description'];
      addInvoiceController.description.text =
          selectedTest['estimate_description'];

      addInvoiceController.tax.text = selectedTest['tax'];
      addInvoiceController.markup.text = selectedTest['markup'];
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
    Future.delayed(const Duration(microseconds: 0), () {
      invoiceController.getCompanyEstimate(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  invoiceForListItems = buildTaskSizeListItems(value);
                }),
              }
            else
              {
                setState(() {
                  invoiceForListItems.clear();
                }),
              }
          });
    });
// TODO: implement initState
    getPermission();
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
          child: Text("Add Invoice",
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
                          "Invoice For",
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
                            selectedInvoice,
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    selectedInvoice == "Test Estimate Section"
                                        ? Colors.black.withOpacity(0.60)
                                        : Colors.black),
                          ),
                          onChanged: onChangeDropdownBoxSize,
                          items: invoiceForListItems),
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
                          controller: addInvoiceController.description,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'enter description',
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
                          "Estimate Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.estimateAmount,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Amount',
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
                          "Total Amount (Estimate and changes in orders)",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.totalAmount,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
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
                          "Paid Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.paidAmount,
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
                          "Tax",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.tax,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Tax',
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
                          "Markup",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.markup,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Markup',
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
                          "Cost Plus",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.costPlus,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter CostPlus',
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
                          controller: addInvoiceController.invoiceDate,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Date',
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
                                  DateFormat('MM/dd/yyyy').format(pickedDate);
                              setState(() {
                                addInvoiceController.invoiceDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              debugPrint("Date is not selected");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
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
                                      addInvoiceController.isPaid.text = '1';
                                    } else {
                                      addInvoiceController.isPaid.text = '0';
                                    }
                                  });
                                }),
                            const Text(
                              'Is Paid',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
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
                          controller: addInvoiceController.signatureName,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter yourName',
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
                                  )),
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
                                            fontSize: 14, color: Colors.white)),
                                  )),
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
                            if (selectedInvoice == "Select Estimate") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Oops!, Please select Estimate from list."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .description.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Oops!, Estimate description missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .estimateAmount.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Oops!, Estimate amount missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .totalAmount.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Total amount missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .paidAmount.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Paid amount missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController.tax.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Tax missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .markup.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Markup missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .costPlus.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Costplus missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .invoiceDate.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Date missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (addInvoiceController
                                .signatureName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, YourName missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (base64ImagePath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Signature missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              await addInvoiceController.addInvoice(context,
                                  signature: base64ImagePath);
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
