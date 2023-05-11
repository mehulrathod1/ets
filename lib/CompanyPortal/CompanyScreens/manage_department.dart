import 'package:etsemployee/CompanyPortal/PopUps/edit_department_popup.dart';
import 'package:etsemployee/Controller/CompanyController/company_add_department_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_delete_department_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_department_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_department_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

import '../../Controller/CompanyController/comapny_edit_deparment_controller.dart';
import '../../Controller/CompanyController/company_department_detail_controller.dart';
import '../../Models/CompanyModels/company_department_detail_model.dart';

class ManageDepartment extends StatefulWidget {
  const ManageDepartment({Key? key}) : super(key: key);

  @override
  State<ManageDepartment> createState() => _ManageDepartmentState();
}

class _ManageDepartmentState extends State<ManageDepartment> {
  bool loading = false;
  late Datum datum;
  late GetCompanyDepartmentModel companyDepartmentModel;
  List<Datum> departmentList = [];
  DeleteDepartmentController departmentController =
      DeleteDepartmentController();
  CompanyDepartmentController companyDepartmentController =
      CompanyDepartmentController();
  CompanyAddDepartmentController addDepartmentController =
      CompanyAddDepartmentController();
  CompanyDepartmentDetailController departmentDetailController =
      CompanyDepartmentDetailController();
  late CompanyDepartmentDetailModel departmentDetailModel;
  CompanyEditDepartmentController editDepartmentController =
      CompanyEditDepartmentController();

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyDepartmentController.getDepartment(context).then((value) {
      setState(() {
        if (value != null) {
          companyDepartmentModel = value;
          departmentList = companyDepartmentModel.data;
          loading = false;
        } else {
          departmentList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No data found'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  Future editDepartment(BuildContext context, String id) async {
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
                            'Edit Department',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                        IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                        controller: editDepartmentController.departmentName,
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                    //   child: Text(
                    //     "Company:",
                    //     style: TextStyle(fontSize: 14),
                    //   ),
                    // ),
                    // Container(
                    //   height: 40,
                    //   child: TextField(
                    //     style: TextStyle(
                    //         height: 1.7, fontSize: 18, color: Colors.black),
                    //     maxLines: 1,
                    //     decoration: InputDecoration(
                    //       hintText: 'Test',
                    //       fillColor: colorLightGray,
                    //       filled: true,
                    //       isDense: true,
                    //       contentPadding:
                    //       EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: Colors.grey, width: 1.0),
                    //           borderRadius: BorderRadius.circular(7)),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: colorGray, width: 1.0),
                    //         borderRadius: BorderRadius.circular(7),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          editDepartmentController
                              .editDepartment(context, id)
                              .then((value) {
                            Navigator.pop(context);
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
                                'Save',
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

  Future addDepartment(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Department Name:",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: addDepartmentController.departmentName,
                    style: const TextStyle(
                        height: 1.7, fontSize: 18, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'IT',
                      fillColor: colorScreenBg,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                // const Padding(
                //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                //   child: Text(
                //     "Company:",
                //     style: TextStyle(fontSize: 14),
                //   ),
                // ),
                // SizedBox(
                //   height: 40,
                //   child: TextField(
                //     style: const TextStyle(fontSize: 18, color: Colors.black),
                //     maxLines: 1,
                //     decoration: InputDecoration(
                //       suffixIcon: Align(
                //         widthFactor: 1,
                //         heightFactor: 1,
                //         child: Icon(
                //           Icons.keyboard_arrow_down_outlined,
                //           color: appThemeGreen,
                //         ),
                //       ),
                //       hintText: 'Test ',
                //       fillColor: colorScreenBg,
                //       filled: true,
                //       isDense: true,
                //       contentPadding:
                //           const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                //       enabledBorder: OutlineInputBorder(
                //           borderSide:
                //               const BorderSide(color: Colors.grey, width: 1.0),
                //           borderRadius: BorderRadius.circular(7)),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: colorGray, width: 1.0),
                //         borderRadius: BorderRadius.circular(7),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      addDepartmentController
                          .addDepartment(context)
                          .then((value) {
                        initialize(context);
                        Navigator.pop(context);
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
                          'Sent',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
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
                            child: const Text(
                              'Add New Department',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: departmentList.length,
                      itemBuilder: (context, index) {
                        var detail = departmentList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                border:
                                    Border.all(width: 1, color: appThemeBlue),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
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
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Company Name: ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              detail.companyName,
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
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                editDepartmentController
                                                        .departmentName.text =
                                                    detail.departmentName;

                                                editDepartment(
                                                    context, detail.id);

                                                await departmentDetailController
                                                    .getDepartmentDetail(
                                                        context, detail.id)
                                                    .then((value) {
                                                  setState(() {
                                                    departmentDetailModel =
                                                        value;
                                                    debugPrint(
                                                        departmentDetailModel
                                                            .data
                                                            .first
                                                            .departmentName);
                                                  });
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: appThemeBlue,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15))),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                        "Edit",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
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
                                                  initialize(context);
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: colorred,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15))),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
