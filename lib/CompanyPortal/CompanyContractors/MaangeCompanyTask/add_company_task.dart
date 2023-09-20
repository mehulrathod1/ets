import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/CompanyController/company_add_task_controller.dart';
import 'package:etsemployee/Controller/CompanyController/get_company_task_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../Controller/CompanyController/company_add_task_controller.dart';
import '../../../Controller/CompanyController/get_company_task_controller.dart';
import '../../../Network/api_constant.dart';

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

class AddCompanyTask extends StatefulWidget {
  const AddCompanyTask({required this.callback, Key? key}) : super(key: key);
  final VoidCallback callback;

  @override
  State<AddCompanyTask> createState() => _AddCompanyTaskState();
}

class _AddCompanyTaskState extends State<AddCompanyTask> {
  bool termsandcond = false;
  GetCompanyTaskController getCompanyTaskController =
      GetCompanyTaskController();
  List<DropdownMenuItem<Object?>> taskOrderListItems = [];
  String selectedOrder = "Select Order";
  List<EmployeeListData> employeeListItems = [];
  String selectedEmployeeListId = "";
  List<EmployeeListData> selectedEmployeeList = [];
  bool loading = false;

  CompanyAddTaskController addTaskController = CompanyAddTaskController();

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      addTaskController.orderId.text = selectedTest['id'];
      selectedOrder = selectedTest['order_name'];
      debugPrint(selectedTest['order_name']);
      debugPrint(selectedTest['id']);
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
            i['order_name'],
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
              addTaskController.employeeList.clear();
              selectedEmployeeList = values;
              for (int i = 0; i < selectedEmployeeList.length; i++) {
                addTaskController.employeeList.text =
                    addTaskController.employeeList.text +
                        selectedEmployeeList[i].employeeName!;
                selectedEmployeeListId =
                    selectedEmployeeListId + selectedEmployeeList[i].id!;
                if (i != selectedEmployeeList.length - 1) {
                  addTaskController.employeeList.text =
                      "${addTaskController.employeeList.text}, ";
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
      await getCompanyTaskController.getTaskOrderList(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  taskOrderListItems = buildTaskSizeListItems(value);
                }),
              }
            else
              {
                setState(() {
                  taskOrderListItems.clear();
                }),
              }
          });

      await addTaskController
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
          child: Text("Add Tasks",
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
                          "Task For",
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
                            selectedOrder,
                            style: TextStyle(
                                fontSize: 18,
                                color: selectedOrder == "Test Order Section"
                                    ? Colors.black.withOpacity(0.60)
                                    : Colors.black),
                          ),
                          onChanged: onChangeDropdownBoxSize,
                          items: taskOrderListItems),
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
                                      addTaskController.taskStatus.text = '1';
                                    } else {
                                      addTaskController.taskStatus.text = '0';
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
                          "Task Name",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: addTaskController.taskName,
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter task name',
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
                          controller: addTaskController.dueDate,
                          //editing controller of this TextField
                          style: const TextStyle(
                              height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Select Date',
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
                                addTaskController.dueDate.text = formattedDate;
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
                          "Task Description",
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
                            controller: addTaskController.taskDescription,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter description',
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
                          controller: addTaskController.employeeList,
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
                            hintText: '',
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
                            addTaskController
                                .addtask(context,
                                    employeeId: selectedEmployeeListId)
                                .then((value) {
                              setState(() {
                                widget.callback();
                                Navigator.pop(context);
                              });
                            });
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Add Task',
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
