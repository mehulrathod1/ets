import 'dart:io';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Controller/CompanyController/compay_add_order_controller.dart';
import '../../../Network/api_constant.dart';

class AddCompanyOrder extends StatefulWidget {
  const AddCompanyOrder({Key? key}) : super(key: key);

  @override
  State<AddCompanyOrder> createState() => _AddCompanyOrderState();
}

class _AddCompanyOrderState extends State<AddCompanyOrder> {
  bool termsandcond = false;
  String signaturePath = "";
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  CompanyAddOrderController addOrderController = CompanyAddOrderController();
  List<DropdownMenuItem<Object?>> orderListItems = [];
  String selectedOrder = "Select Estimate";

  Future getPermission() async {
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
    signaturePath = "";
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    var path = Platform.isAndroid
        ? await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS)
        : await getApplicationDocumentsDirectory();
    await Directory('$path/Ets signature').create(recursive: true);
    setState(() {
      File('$path/Ets signature/signature.png')
          .writeAsBytesSync(bytes!.buffer.asInt8List());
      signaturePath = '$path/Ets signature/signature.png';
    });
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () async {
      addOrderController.orderStatus.text = "0";
      await addOrderController
          .getEstimateOrderListForCompany(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      orderListItems = buildTaskSizeListItems(value);
                    }),
                  }
                else
                  {
                    setState(() {
                      orderListItems.clear();
                    }),
                  }
              });
      await getPermission();
    });

    super.initState();
  }

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      addOrderController.estimateId.text = selectedTest['estimate_id'];
      selectedOrder = selectedTest['estimate_name'];
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Add Order",
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
                        "Work Order For",
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
                          selectedOrder,
                          style: TextStyle(
                              fontSize: 18,
                              color: selectedOrder == "Select Estimate"
                                  ? Colors.black.withOpacity(0.60)
                                  : Colors.black),
                        ),
                        onChanged: onChangeDropdownBoxSize,
                        items: orderListItems),
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
                                    addOrderController.orderStatus.text = '1';
                                  } else {
                                    addOrderController.orderStatus.text = '0';
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
                        "Order Name",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: addOrderController.orderName,
                        style: const TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter order name',
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
                        "Order Description",
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
                          controller: addOrderController.orderDescription,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter order description',
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
                        "Change Description",
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
                          controller: addOrderController.changeDescription,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter change description',
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
                        "Estimate Amount",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: addOrderController.amount,
                        style: const TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter estimate amount',
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
                        "Additional Amount",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter additional amount',
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
                        "Start Date",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: addOrderController.startDate,
                        style: const TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                              addOrderController.startDate.text =
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
                        "Due Date",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: addOrderController.dueDate,
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
                              addOrderController.dueDate.text = formattedDate;
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
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: colorGray),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 4.0),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0, right: 8),
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
                            padding: const EdgeInsets.only(top: 16.0, right: 8),
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
                          if (selectedOrder == "Test Estimate Section") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Oops!, Please select work order from list."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (addOrderController
                              .orderName.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Oops!, Order name missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (addOrderController
                              .orderDescription.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Oops!, Order description missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (addOrderController
                              .changeDescription.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Oops!, Order change description missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (addOrderController.amount.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Oops!, Order amount missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (addOrderController
                              .startDate.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Oops!, Order start date missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (addOrderController.dueDate.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Oops!, Order due date missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else if (signaturePath.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Oops!, signature missing."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            await addOrderController.addOrder(context,
                                signature: signaturePath);
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
      )),
    );
  }
}
