import 'package:etsemployee/Controller/CompanyController/company_total_department.dart';
import 'package:etsemployee/Controller/CompanyController/company_total_employee_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_total_department_model.dart';
import 'package:etsemployee/Models/CompanyModels/company_total_emp_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'company_notification.dart';
import 'manage_approval.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({this.changeScreen, Key? key}) : super(key: key);

  Function(int)? changeScreen;

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> with SingleTickerProviderStateMixin {
  late TabController _controller;
  CompanyTotalEmployeeController totalEmployeeController = CompanyTotalEmployeeController();
  TotalEmployeeModel? totalEmployeeModel;
  CompanyTotalDepartmentModel? departmentModel;
  CompanyTotalDepartmentController companyTotalDepartmentController = CompanyTotalDepartmentController();
  bool loading = false;
  String totalEmployee = 'aaa';

  @override
  void initState() {
    super.initState();
    initialize(context);
    initializ(context);
    _controller = TabController(length: 2, vsync: this);
  }

  Future initialize(BuildContext context) async {
    loading = true;

    totalEmployeeController.getTotalEmployee(context).then((value) {
      setState(() {
        if (value != null) {
          totalEmployeeModel = value;
          debugPrint(totalEmployeeModel?.data.toString());
        } else {
          loading = false;
        }
      });
    });
  }

  Future initializ(BuildContext context) async {
    loading = true;
    companyTotalDepartmentController.getTotalDepartment(context).then((value) {
      setState(() {
        if (value != null) {
          departmentModel = value;
          loading = false;
        } else {
          loading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              widget.changeScreen!(1);
                            },
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: colorPinkLight,
                                border: Border.all(color: colorPink, width: 1),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        totalEmployeeModel!.data.toString(),
                                        style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                                      ),
                                      const ImageIcon(
                                        AssetImage("assets/nounGroup.png"),
                                        size: 60,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text("Employee(s)")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              widget.changeScreen!(1);
                            },
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: colorGreenLight,
                                border: Border.all(color: colorGreen, width: 1),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        departmentModel!.data.toString(),
                                        style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                                      ),
                                      const ImageIcon(
                                        AssetImage("assets/department.png"),
                                        size: 60,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text("Department(s)")
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TabBar(
                      tabs: const [
                        Tab(
                            child: Text(
                          'Notification',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        Tab(
                          child: Text(
                            'Approvals',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                      controller: _controller,
                      labelColor: appThemeGreen,
                      indicatorColor: appThemeGreen,
                      unselectedLabelColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: const [
                      CompanyNotification(),
                      ManageApproval(),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
