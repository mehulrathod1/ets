import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../Controller/CompanyController/company_add_invoice_controller.dart';
import '../../../Controller/CompanyController/company_invoive_controller.dart';
import '../../../Network/api_constant.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:io';

class EditCompanyInvoice extends StatefulWidget {
  EditCompanyInvoice(
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

  @override
  State<EditCompanyInvoice> createState() => _EditCompanyInvoiceState();
}

class _EditCompanyInvoiceState extends State<EditCompanyInvoice> {
  bool termsandcond = false;
  String base64ImagePath = "";
  String signaturePath = "";
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  CompanyInvoiceController invoiceController = CompanyInvoiceController();
  List<DropdownMenuItem<Object?>> invoiceForListItems = [];
  String selectedInvoice = "Select Estimate";
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
    File(signaturePath).delete();
    base64ImagePath = '';
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
    // print(widget.estimateId);
    // String id;
    // String estimateId;
    // String invoiceFor;
    // String invoiceDescription;
    // String amount;
    // String invoiceDate;
    // String tax;
    // String dueAmount;
    // String totalAmount;
    // String isPaid;
    // String paidBy;
    // String signatureName;
    //
    DateTime now = DateTime.now();
    widget.invoiceDate = DateFormat('MM-dd-yyyy').format(now);
    addInvoiceController.description.text = widget.invoiceDescription;
    addInvoiceController.estimateAmount.text = widget.amount;
    addInvoiceController.invoiceDate.text = widget.invoiceDate;
    addInvoiceController.tax.text = widget.tax;
    addInvoiceController.totalAmount.text = widget.totalAmount;
    addInvoiceController.isPaid.text = widget.isPaid;
    addInvoiceController.paidBy.text = widget.paidBy;
    addInvoiceController.signatureName.text = widget.signatureName;

    if (widget.isPaid == '1') {
      termsandcond = true;
    } else {
      termsandcond = false;
    }

    Future.delayed(const Duration(microseconds: 0), () {
      invoiceController.getCompanyEstimate(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  invoiceForListItems = buildTaskSizeListItems(value);

                  for (int i = 0; i < value.length; i++) {
                    if (value[i]["id"] == widget.estimateId) {
                      addInvoiceController.invoiceForId.text = value[i]["id"];
                      selectedInvoice = value[i]["estimate_name"];
                    }
                  }
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
          child: Text("Edit Invoice",
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
                          "Change Order Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
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
                          "Amount you want to pay",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addInvoiceController.amountNow,
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
                            await addInvoiceController.editInvoice(
                                context, widget.id, base64ImagePath);
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
