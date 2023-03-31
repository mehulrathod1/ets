import 'package:etsemployee/Screens/Contractors/ManageOrder/add_order.dart';
import 'package:etsemployee/Screens/Contractors/ManageOrder/edit_order.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../Controller/EmployeeController/employee_delete_order_controller.dart';
import '../../../Controller/EmployeeController/employee_order_controller.dart';
import '../../../Models/EmployeeModel/employee_delete_order_model.dart';
import '../../../Models/EmployeeModel/employee_order_model.dart';
import '../../../utils/Colors.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({Key? key}) : super(key: key);

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  EmployeeOrderController employeeOrderController = EmployeeOrderController();
  late EmployeeOrderModel employeeOrderModel;
  List<ListElement> orderList = [];

  EmployeeDeleteOrderController deleteOrderController =
      EmployeeDeleteOrderController();
  late EmployeeDeleteOrderModel deleteOrderModel;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    employeeOrderController.getEmployeeContact(context).then((value) {
      setState(() {
        employeeOrderModel = value;
        orderList = employeeOrderModel.data.list;
        print(value.message);
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Manage Order",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
            ),
          ),
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: Icon(
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
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.search,
                          color: appThemeGreen,
                        ),
                      ),
                      hintText: 'Search',
                      fillColor: colorScreenBg,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorGray, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddOrder()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Add New Order',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      var detail = orderList[index];

                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Container(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80)),
                                  child: Image.asset(
                                    'assets/man.jpeg',
                                    fit: BoxFit.cover,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.orderName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      detail.orderDescription,
                                      style: TextStyle(
                                          fontSize: 14, color: colorTextGray),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      detail.dueDate.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: appThemeBlue,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditOrder()));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 1,
                                          height: 35,
                                          child: const DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              deleteOrderController
                                                  .deleteOrder(
                                                      context, detail.id!)
                                                  .then((value) {
                                                deleteOrderModel = value;
                                                print(deleteOrderModel.message);
                                                initialize(context);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorred,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15))),
                                              height: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        )),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
