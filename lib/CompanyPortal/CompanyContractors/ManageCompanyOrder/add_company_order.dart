// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/CompanyController/compay_add_order_controller.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

class AddCompanyOrder extends StatefulWidget {
  const AddCompanyOrder({Key? key}) : super(key: key);

  @override
  State<AddCompanyOrder> createState() => _AddCompanyOrderState();
}

class _AddCompanyOrderState extends State<AddCompanyOrder> {
  bool termsandcond = false;
  bool loading = false;
  String signaturePath = "";
  String base64ImagePath = "";
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  CompanyAddOrderController addOrderController = CompanyAddOrderController();
  List<DropdownMenuItem<Object?>> orderListItems = [];
  List<EmployeeListData> employeeListItems = [];
  String selectedOrder = "Select Estimate";
  String selectedEmployeeListId = "";
  List<EmployeeListData> selectedEmployeeList = [];

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
  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    Uint8List unit8 = bytes!.buffer.asUint8List();
    base64ImagePath = base64.encode(unit8);

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
      addOrderController.estimateId.text = selectedTest['estimate_id'];
      selectedOrder = selectedTest['estimate_name'];
      debugPrint(addOrderController.estimateId.text);
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
              addOrderController.employeeList.clear();
              selectedEmployeeList = values;
              for (int i = 0; i < selectedEmployeeList.length; i++) {
                addOrderController.employeeList.text =
                    addOrderController.employeeList.text +
                        selectedEmployeeList[i].employeeName!;
                selectedEmployeeListId =
                    selectedEmployeeListId + selectedEmployeeList[i].id!;
                if (i != selectedEmployeeList.length - 1) {
                  addOrderController.employeeList.text =
                      "${addOrderController.employeeList.text}, ";
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
    loading = true;
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
      await addOrderController
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
      await getPermission();
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
          child: Text("Add Order",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                itemWidth:
                                    MediaQuery.of(context).size.width - 30,
                                itemTextstyle: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                boxTextstyle: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                boxWidth: MediaQuery.of(context).size.width,
                                boxHeight: 40,
                                boxDecoration: BoxDecoration(
                                  color: colorScreenBg,
                                  border:
                                      Border.all(color: colorGray, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
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
                                      fillColor: MaterialStateProperty.all(
                                          appThemeGreen),
                                      onChanged: (v) {
                                        setState(() {
                                          termsandcond = v!;
                                          if (termsandcond == true) {
                                            addOrderController
                                                .orderStatus.text = '1';
                                          } else {
                                            addOrderController
                                                .orderStatus.text = '0';
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
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
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
                                    borderSide: BorderSide(
                                        color: colorGray, width: 1.0),
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
                                  border:
                                      Border.all(width: 1, color: colorGray),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextField(
                                  controller:
                                      addOrderController.orderDescription,
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
                                  border:
                                      Border.all(width: 1, color: colorGray),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextField(
                                  controller:
                                      addOrderController.changeDescription,
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
                                "Employee List",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                controller: addOrderController.employeeList,
                                maxLines: 1,
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixIcon: Align(
                                    widthFactor: 1,
                                    heightFactor: 1,
                                    child: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: appThemeGreen,
                                    ),
                                  ),
                                  hintText:
                                      'Test Edit1, Test Edit2, Test Edit3',
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
                                    borderSide: BorderSide(
                                        color: colorGray, width: 1.0),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                onTap: () {
                                  showMultiSelect(context);
                                },
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
                                style: const TextStyle(
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
                                maxLines: 1,
                                controller: addOrderController.amount,
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
                                    borderSide: BorderSide(
                                        color: colorGray, width: 1.0),
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
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
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
                                    borderSide: BorderSide(
                                        color: colorGray, width: 1.0),
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
                                        DateFormat('MM/dd/yyyy')
                                            .format(pickedDate);
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
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
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
                                    borderSide: BorderSide(
                                        color: colorGray, width: 1.0),
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
                                        DateFormat('MM/dd/yyyy')
                                            .format(pickedDate);
                                    setState(() {
                                      addOrderController.dueDate.text =
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
                                controller: addOrderController.signName,
                                style: const TextStyle(
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Enter your name',
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
                                    borderSide: BorderSide(
                                        color: colorGray, width: 1.0),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: colorGray),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
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
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _handleClearButtonPressed();
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: colorred),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "Clear Signature",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _handleSaveButtonPressed();
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (selectedOrder == "Select Estimate") {
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
                                        content:
                                            Text("Oops!, Order name missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                  // else if (addOrderController
                                  //     .orderDescription.text.isEmpty) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       content: Text(
                                  //           "Oops!, Order description missing."),
                                  //       duration: Duration(seconds: 1),
                                  //     ),
                                  //   );
                                  // }
                                  // else if (addOrderController
                                  //     .changeDescription.text.isEmpty) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       content: Text(
                                  //           "Oops!, Order change description missing."),
                                  //       duration: Duration(seconds: 1),
                                  //     ),
                                  //   );
                                  // }
                                  else if (addOrderController
                                      .employeeList.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, Order employee list missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (addOrderController
                                      .amount.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, Order amount missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (addOrderController
                                      .startDate.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, Order start date missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (addOrderController
                                      .dueDate.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, Order due date missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (addOrderController
                                      .signName.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, signature name missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (base64ImagePath.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Oops!, signature missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else {
                                    await addOrderController.addOrder(context,
                                        signature: base64ImagePath,
                                        employeeId: selectedEmployeeListId);
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
    );
  }
}
