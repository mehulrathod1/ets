// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../Controller/EmployeeController/employee_edit_invoice_controller.dart';

class EditInvoice extends StatefulWidget {
  EditInvoice(
      {required this.id,
      required this.estimateId,
      required this.invoiceFor,
      required this.invoiceDescription,
      required this.amount,
      required this.invoiceDate,
      required this.tax,
      required this.dueAmount,
      required this.totalAmount,
      required this.isPaid,
      required this.paidBy,
      required this.signatureName,
      required this.signature,
      Key? key})
      : super(key: key);

  String id;
  String estimateId;
  String invoiceFor;
  String invoiceDescription;
  String amount;
  String invoiceDate;
  String tax;
  String dueAmount;
  String totalAmount;
  String isPaid;
  String paidBy;
  String signatureName;
  String signature;

  @override
  State<EditInvoice> createState() => _EditInvoiceState();
}

class _EditInvoiceState extends State<EditInvoice> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  TextEditingController invoiceDate = TextEditingController();
  bool termsandcond = false;
  String signaturePath = "";
  String base64ImagePath = "";
  EmployeeEditInvoiceController editInvoiceController =
      EmployeeEditInvoiceController();

  List<DropdownMenuItem<Object?>> orderListItems = [];
  String selectEstimate = "Select Estimate";

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      selectEstimate = selectedTest['estimate_name'];
      editInvoiceController.invoiceForId.text = selectedTest['estimate_id'];
      if (selectedTest['estimate_description'] != null) {
        editInvoiceController.description.text =
            selectedTest['estimate_description'];
      }
      if (selectedTest['amount'] != null) {
        editInvoiceController.estimateAmount.text = selectedTest['amount'];
      }
      if (selectedTest['estimate_description'] != null) {
        editInvoiceController.changeDescription.text =
            selectedTest['estimate_description'];
      }
      if (selectedTest['amount'] != null) {
        editInvoiceController.orderAmount.text = selectedTest['amount'];
      }
      if (selectedTest['tax'] != null) {
        editInvoiceController.tax.text = selectedTest['tax'];
      }
      if (selectedTest['markup'] != null) {
        editInvoiceController.markup.text = selectedTest['markup'];
      }
      if (selectedTest['cost_plus'] != null) {
        editInvoiceController.costPlus.text = selectedTest['cost_plus'];
      }
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
    print(widget.estimateId);
    DateTime now = DateTime.now();
    widget.invoiceDate = DateFormat('MM/dd/yyyy').format(now);
    editInvoiceController.description.text = widget.invoiceDescription;
    editInvoiceController.estimateAmount.text = widget.amount;
    editInvoiceController.invoiceDate.text = widget.invoiceDate;
    editInvoiceController.tax.text = widget.tax;
    editInvoiceController.totalAmount.text = widget.totalAmount;
    editInvoiceController.isPaid.text = widget.isPaid;
    editInvoiceController.paidBy.text = widget.paidBy;
    editInvoiceController.signName.text = widget.signatureName;

    if (widget.isPaid == '1') {
      termsandcond = true;
    } else {
      termsandcond = false;
    }

    Future.delayed(const Duration(microseconds: 0), () async {
      await editInvoiceController.getEmployeeEstimate(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  orderListItems = buildTaskSizeListItems(value);

                  for (int i = 0; i < value.length; i++) {
                    if (value[i]["estimate_id"] == widget.estimateId) {
                      editInvoiceController.invoiceForId.text =
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
    setState(() {});
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    Uint8List unit = bytes!.buffer.asUint8List();
    base64ImagePath = base64.encode(unit);

    print(base64ImagePath);
  }

  // void _handleSaveButtonPressed() async {
  //   signaturePath = "";
  //   final data =
  //       await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
  //   final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
  //   var path = Platform.isAndroid
  //       ? await ExternalPath.getExternalStoragePublicDirectory(
  //           ExternalPath.DIRECTORY_DOWNLOADS)
  //       : await getApplicationDocumentsDirectory();
  //   await Directory('$path/Ets signature').create(recursive: true);
  //   setState(() {
  //     File('$path/Ets signature/signature.png')
  //         .writeAsBytesSync(bytes!.buffer.asInt8List());
  //     signaturePath = '$path/Ets signature/signature.png';
  //   });
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return Scaffold(
  //           appBar: AppBar(),
  //           body: Center(
  //             child: Container(
  //               color: Colors.grey[300],
  //               child: Image.memory(bytes!.buffer.asUint8List()),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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
          child: Text("Edit Invoice",
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
                              selectEstimate,
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      selectEstimate == "Test Estimate Section"
                                          ? Colors.black.withOpacity(0.60)
                                          : Colors.black),
                            ),
                            onChanged: onChangeDropdownBoxSize,
                            items: orderListItems),

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
                            controller: editInvoiceController.description,
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
                            "Estimate Amount",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: editInvoiceController.estimateAmount,
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
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        //   child: Text(
                        //     "Changes Order Description",
                        //     style: TextStyle(fontSize: 14),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 40,
                        //   child: TextField(
                        //     style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                        //     maxLines: 1,
                        //     decoration: InputDecoration(
                        //       fillColor: colorLightGray,
                        //       filled: true,
                        //       isDense: true,
                        //       contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        //       enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: colorGray, width: 1.0),
                        //         borderRadius: BorderRadius.circular(7),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        //   child: Text(
                        //     "Change Order Amount",
                        //     style: TextStyle(fontSize: 14),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 40,
                        //   child: TextField(
                        //     style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                        //     maxLines: 1,
                        //     decoration: InputDecoration(
                        //       hintText: '5000',
                        //       fillColor: colorLightGray,
                        //       filled: true,
                        //       isDense: true,
                        //       contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        //       enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: colorGray, width: 1.0),
                        //         borderRadius: BorderRadius.circular(7),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                            controller: editInvoiceController.totalAmount,
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
                            "Paid Amount",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: editInvoiceController.paidAmount,
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
                            controller: editInvoiceController.tax,
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
                            "Markup",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: editInvoiceController.markup,
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
                            "Cost Plus",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: editInvoiceController.costPlus,
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
                            controller: editInvoiceController.invoiceDate,
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
                                    DateFormat('MM/dd/yyyy').format(pickedDate);
                                setState(() {
                                  editInvoiceController.invoiceDate.text =
                                      formattedDate;
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
                                        editInvoiceController.isPaid.text = '1';
                                      } else {
                                        editInvoiceController.isPaid.text = '0';
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
                            controller: editInvoiceController.signName,
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
                              image: NetworkImage(widget.signature),
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
                              if (selectEstimate == "Select Estimate") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Oops!, Please select Estimate from list."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .description.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Oops!, Estimate description missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .estimateAmount.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, Estimate amount missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .totalAmount.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, Total amount missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .paidAmount.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, Paid amount missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .tax.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Oops!, Tax missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .markup.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Oops!, Markup missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .costPlus.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Oops!, Costplus missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .invoiceDate.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Oops!, Date missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (editInvoiceController
                                  .signName.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, Signature name missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                              // else if (base64ImagePath.isEmpty) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text("Oops!, Signature missing."),
                              //       duration: Duration(seconds: 1),
                              //     ),
                              //   );
                              // }
                              else {
                                await editInvoiceController.editInvoice(context,
                                    signature: base64ImagePath, id: widget.id);
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
