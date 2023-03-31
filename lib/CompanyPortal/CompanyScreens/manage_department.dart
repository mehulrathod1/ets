import 'package:flutter/material.dart';
import '../../Controller/CompanyController/company_add_department_controller.dart';
import '../../Controller/CompanyController/company_delete_department_controller.dart';
import '../../Controller/CompanyController/company_department_controller.dart';
import '../../Models/CompanyModels/company_add_department_model.dart';
import '../../Models/CompanyModels/company_delete_department_model.dart';
import '../../Models/CompanyModels/company_department_model.dart';
import '../../utils/Colors.dart';
import '../PopUps/add_department_popup.dart';
import '../PopUps/edit_department_popup.dart';
import 'company_dashboard.dart';

class ManageDepartment extends StatefulWidget {
  const ManageDepartment({Key? key}) : super(key: key);

  @override
  State<ManageDepartment> createState() => _ManageDepartmentState();
}

class _ManageDepartmentState extends State<ManageDepartment> {
  CompanyDepartmentController companyDepartmentController =
      CompanyDepartmentController();
  late GetCompanyDepartmentModel companyDepartmentModel;
  late Datum datum;
  List<Datum> departmentList = [];

  DeleteDepartmentController departmentController =
      DeleteDepartmentController();
  late CompanyDeleteDepartmentModel deleteDepartmentModel;

  CompanyAddDepartmentController addDepartmentController =
      CompanyAddDepartmentController();
  late CompanyAddDepartmentModel addDepartmentModel;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    companyDepartmentController.getDepartment(context).then((value) {
      setState(() {
        companyDepartmentModel = value;
        departmentList = companyDepartmentModel.data;
      });
    });
  }

  Future addDepartment(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Add Department',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                        Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "Department Name:",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        controller: addDepartmentController.departmentName,
                        style: TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'IT',
                          fillColor: colorScreenBg,
                          filled: true,
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                      child: Text(
                        "Company:",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
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
                              Icons.keyboard_arrow_down_outlined,
                              color: appThemeGreen,
                            ),
                          ),
                          hintText: 'Test ',
                          fillColor: colorScreenBg,
                          filled: true,
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                        onTap: () {
                          addDepartmentController
                              .addDepartment(context)
                              .then((value) {
                            addDepartmentModel = value;
                            print(addDepartmentModel.message);

                            initialize(context);
                          });
                        },
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeGreen,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Sent',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8, right: 8, top: 10.0, bottom: 10),
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: appThemeGreen,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        addDepartment(context);
                      },
                      child: Text(
                        'Add New Department',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: departmentList.length,
                  itemBuilder: (context, index) {
                    var detail = departmentList[index];

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(width: 1, color: appThemeBlue),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Department Name: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          detail.departmentName.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: colorTextGray),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Company Name: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Test",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: colorTextGray),
                                        ),
                                      ],
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
                                              editDepartment(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: appThemeBlue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15))),
                                              height: double.infinity,
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
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              departmentController
                                                  .deleteDepartment(
                                                      context, detail.id)
                                                  .then((value) {
                                                deleteDepartmentModel = value;
                                                print(deleteDepartmentModel
                                                    .message);

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
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
