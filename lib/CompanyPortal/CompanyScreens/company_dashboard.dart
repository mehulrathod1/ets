// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names, constant_identifier_names

import 'package:etsemployee/CommonWidget/my_drawer_header.dart';
import 'package:etsemployee/CompanyPortal/CompanyContractors/ManageCompanyProfile/company_profile.dart';
import 'package:etsemployee/CompanyPortal/CompanyContractors/company_contractors_screen.dart';
import 'package:etsemployee/CompanyPortal/CompanyScreens/employee_management.dart';
import 'package:etsemployee/CompanyPortal/CompanyScreens/request.dart';
import 'package:etsemployee/Controller/CompanyController/company_profile_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_profile_model.dart';
import 'package:etsemployee/Screens/UserSelectionScreen.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'agency_management.dart';
import 'company_agreement.dart';
import 'company_fix_hour_request.dart';
import 'company_home.dart';
import 'company_notification.dart';
import 'inbox_screen.dart';
import 'manage_approval.dart';
import 'manage_department.dart';
import 'manage_report.dart';

class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({Key? key}) : super(key: key);

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  bool loading = false;
  var currentPage = DrawerSelection.Dashboard;
  String appBarTitle = "";
  int _selectedIndex = 0;
  var container;
  CompanyProfileController companyLoginController = CompanyProfileController();
  CompanyProfileModel? companyProfileModel;

  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserSelectionScreen()), (route) => false);
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyLoginController.getCompanyProfile(context).then((value) {
      setState(() {
        companyProfileModel = value;
        debugPrint(companyProfileModel!.data.companyName);
        loading = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget MyDrawerList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.grid_view_outlined, currentPage == DrawerSelection.Dashboard ? true : false),
          menuItem(2, "Employee Management", Icons.person_outline, currentPage == DrawerSelection.EmployeeManagement ? true : false),
          menuItem(3, "Agency/Agent Management", Icons.person_outline, currentPage == DrawerSelection.AgencyAgentManagement ? true : false),
          menuItem(4, "Inbox", Icons.weekend_outlined, currentPage == DrawerSelection.Inbox ? true : false),
          menuItem(5, "Notification", Icons.notifications_none, currentPage == DrawerSelection.Notification ? true : false),
          menuItem(6, "FixHoursRequest", Icons.access_time, currentPage == DrawerSelection.FixHoursRequest ? true : false),
          menuItem(7, "Approval", Icons.approval, currentPage == DrawerSelection.Approval ? true : false),
          menuItem(8, "Department", Icons.work_outline, currentPage == DrawerSelection.Department ? true : false),
          menuItem(9, "Report", Icons.report_gmailerrorred, currentPage == DrawerSelection.Report ? true : false),
          menuItem(10, "ContractorsBackOffice", Icons.work_outline, currentPage == DrawerSelection.ContractorsBackOffice ? true : false),
          menuItem(11, "Subscription Agreement", Icons.check_box_outlined, currentPage == DrawerSelection.SubscriptionAgreement ? true : false),
          menuItem(12, "HowItWorks", Icons.help_outline, currentPage == DrawerSelection.HowItWorks ? true : false),
          menuItem(13, "Request", Icons.north_east, currentPage == DrawerSelection.Request ? true : false),
          menuItem(14, "Logout", Icons.logout, currentPage == DrawerSelection.Logout ? true : false),
          const Padding(
            padding: EdgeInsets.only(top: 100.0, right: 16, bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Employee Tracking Solutions.\n Copyright © 2023 All Rights Reserved.',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSelection.Dashboard;
            } else if (id == 2) {
              currentPage = DrawerSelection.EmployeeManagement;
            } else if (id == 3) {
              currentPage = DrawerSelection.AgencyAgentManagement;
            } else if (id == 4) {
              currentPage = DrawerSelection.Inbox;
            } else if (id == 5) {
              currentPage = DrawerSelection.Notification;
            } else if (id == 6) {
              currentPage = DrawerSelection.FixHoursRequest;
            } else if (id == 7) {
              currentPage = DrawerSelection.Approval;
            } else if (id == 8) {
              currentPage = DrawerSelection.Department;
            } else if (id == 9) {
              currentPage = DrawerSelection.Report;
            } else if (id == 10) {
              currentPage = DrawerSelection.ContractorsBackOffice;
            } else if (id == 11) {
              currentPage = DrawerSelection.SubscriptionAgreement;
            } else if (id == 12) {
              currentPage = DrawerSelection.HowItWorks;
            } else if (id == 13) {
              currentPage = DrawerSelection.Request;
            } else if (id == 14) {
              currentPage = DrawerSelection.Logout;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 24,
                  color: selected ? appThemeGreen : Colors.black,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  title,
                  style: TextStyle(color: selected ? appThemeGreen : Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentPage == DrawerSelection.Dashboard) {
      container = const CompanyHome();
      appBarTitle = "Dashboard";
    }
    if (currentPage == DrawerSelection.EmployeeManagement) {
      container = const EmployeeManagement();
      appBarTitle = "Employee";
    }
    if (currentPage == DrawerSelection.AgencyAgentManagement) {
      container = const AgencyManagement();
      appBarTitle = "Agent Or Agency";
    }
    if (currentPage == DrawerSelection.Inbox) {
      container = const InboxScreen();
      appBarTitle = "Inbox";
    }
    if (currentPage == DrawerSelection.Notification) {
      container = const CompanyNotification();
      appBarTitle = "Notification";
    }
    if (currentPage == DrawerSelection.FixHoursRequest) {
      container = const CompanyFixHourRequest();
      appBarTitle = "Fix Hours Request";
    }
    if (currentPage == DrawerSelection.Approval) {
      container = const ManageApproval();
      appBarTitle = "Manage Approval";
    }
    if (currentPage == DrawerSelection.Department) {
      container = const ManageDepartment();
      appBarTitle = "Manage Department";
    }
    if (currentPage == DrawerSelection.Report) {
      container = const ManageReport();
      appBarTitle = "Manage Report";
    }
    if (currentPage == DrawerSelection.ContractorsBackOffice) {
      container = const CompanyContractorsScreen();
      appBarTitle = "Contractors Back Office";
    }
    if (currentPage == DrawerSelection.SubscriptionAgreement) {
      container = const CompanyAgreement();
      appBarTitle = "Agreement";
    }
    if (currentPage == DrawerSelection.Request) {
      container = const CompanyRequest();
      appBarTitle = "Request";
    }
    if (currentPage == DrawerSelection.Logout) {
      navigate();
    }

    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: Center(
                child: Text(appBarTitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyProfile()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/man.jpeg'),
                    ),
                  ),
                ),
              ],
              leading: Builder(builder: (context) {
                return GestureDetector(
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
            ),
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [MyDrawerHeader(userName: companyProfileModel!.data.username, email: companyProfileModel!.data.email, profilePicture: ""), MyDrawerList()],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: colorScreenBg,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                boxShadow: const [
                  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/home.png"),
                        ),
                        label: "",
                        backgroundColor: Colors.green),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/chat.png"),
                        ),
                        label: "",
                        backgroundColor: Colors.green),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/location.png"),
                        ),
                        label: "",
                        backgroundColor: Colors.green),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/notification.png"),
                        ),
                        label: "",
                        backgroundColor: Colors.green),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/profile1.png"),
                        ),
                        label: "",
                        backgroundColor: Colors.green),
                  ],
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  selectedItemColor: appThemeGreen,
                  unselectedItemColor: Colors.black,
                  iconSize: 30,
                  onTap: _onItemTapped,
                  elevation: 5),
            ),
            body: container,
          );
  }
}

enum DrawerSelection { Dashboard, EmployeeManagement, AgencyAgentManagement, Inbox, Notification, FixHoursRequest, Approval, Department, Report, ContractorsBackOffice, SubscriptionAgreement, HowItWorks, Request, Logout }
