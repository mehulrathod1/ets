import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Controller/CompanyController/company_edit_employee_controller.dart';
import '../../Controller/CompanyController/company_employee_detail_controller.dart';
import '../../Models/CompanyModels/company_edit_employee_model.dart';
import '../../Models/CompanyModels/company_employee_detail_model.dart';
import '../../../Network/api_constant.dart';

class EditEmployee extends StatefulWidget {
  EditEmployee({required this.employeeId, Key? key}) : super(key: key);

  String employeeId;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  CompanyEmployeeDetailController employeeDetailController =
      CompanyEmployeeDetailController();
  late CompanyEmployeeDetailModel employeeDetailModel;
  bool loading = false;
  CompanyEditEmployeeController editEmployeeController =
      CompanyEditEmployeeController();
  late CompanyEditEmployeeModel companyEditEmployeeModel;
  String selectedDepartment = "Select Department";
  List<DropdownMenuItem<Object?>> departmentListItems = [];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(microseconds: 0), () {
      employeeDetailController.getDepartmentList(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  departmentListItems = buildTaskSizeListItems(value);
                }),
              }
            else
              {
                setState(() {
                  departmentListItems.clear();
                }),
              }
          });
    });
    // Future.delayed(Duration.zero, () {
    initialize(context, widget.employeeId);
    // });
    super.initState();
  }

  Future initialize(BuildContext context, String id) async {
    loading = true;
    await employeeDetailController.employeeDetail(context, id).then((value) {
      setState(() {
        employeeDetailModel = value;
        debugPrint(employeeDetailModel.data.employeeName);

        editEmployeeController.email.text = employeeDetailModel.data.email;
        editEmployeeController.employeeName.text =
            employeeDetailModel.data.employeeName;

        loading = false;
      });
    });
  }

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      // addTaskController.orderId.text = selectedTest['estimate_id'];
      selectedDepartment = selectedTest['department_name'];
      editEmployeeController.department.text = selectedTest['id'];
      print(selectedTest['id']);
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
            i['department_name'],
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
          child: Text("Edit Employee",
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                "Employee Email",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: editEmployeeController.email,
                                style: const TextStyle(
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: employeeDetailModel.data.email,
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
                                "Employee Name",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: editEmployeeController.employeeName,
                                style: const TextStyle(
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText:
                                      employeeDetailModel.data.employeeName,
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
                                "Password:(only add if you want to change)",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: editEmployeeController.password,
                                style: const TextStyle(
                                    height: 1.7,
                                    fontSize: 18,
                                    color: Colors.black),
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
                                "Department",
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
                                  selectedDepartment,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: selectedDepartment ==
                                              "Test Estimate Section"
                                          ? Colors.black.withOpacity(0.60)
                                          : Colors.black),
                                ),
                                onChanged: onChangeDropdownBoxSize,
                                items: departmentListItems),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (editEmployeeController
                                      .email.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Oops!, Email missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (editEmployeeController
                                      .employeeName.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, Employee Name missing."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (selectedDepartment ==
                                      "Select Department") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Oops!, Please select Department from list."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else {
                                    await editEmployeeController
                                        .editEmployee(context);
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
