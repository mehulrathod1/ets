// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names, constant_identifier_names

import 'package:etsemployee/CommonWidget/my_drawer_header.dart';
import 'package:etsemployee/SalesPortal/ManageAgent/manage_agent.dart';
import 'package:etsemployee/SalesPortal/ManageSalesCompany/ManageSalesCompany.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/reseller_agreement.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_home.dart';
import 'package:etsemployee/SalesPortal/SalesScreen/sales_notification.dart';
import 'package:etsemployee/Screens/UserSelectionScreen.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage_sales_request.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({Key? key}) : super(key: key);

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  var currentPage = DrawerSelection.Dashboard;
  String appBarTitle = "";
  int _selectedIndex = 0;
  var container;

  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserSelectionScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (currentPage == DrawerSelection.Dashboard) {
      container = const SalesHome();
      appBarTitle = "Dashboard";
    }
    if (currentPage == DrawerSelection.AddAgent) {
      container = const ManageAgent();
      appBarTitle = "ManageAgent";
    }
    if (currentPage == DrawerSelection.Company) {
      container = const ManageSalesCompany();
      appBarTitle = "Manage Company";
    }
    if (currentPage == DrawerSelection.Request) {
      container = const ManageSalesRequest();
      appBarTitle = "Manage Request";
    }
    if (currentPage == DrawerSelection.Notification) {
      container = const SalesNotification();
      appBarTitle = "Notification";
    }
    if (currentPage == DrawerSelection.ResellerAgreement) {
      container = const ResellerAgreement();
      appBarTitle = "ResellerAgreement";
    }
    if (currentPage == DrawerSelection.Logout) {
      navigate();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text(appBarTitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/man.jpeg'),
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
            children: [MyDrawerHeader(userName: "", email: "", profilePicture: ""), MyDrawerList()],
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
          menuItem(2, "Add Agent", Icons.person_outline, currentPage == DrawerSelection.AddAgent ? true : false),
          menuItem(3, "Company", Icons.person_outline, currentPage == DrawerSelection.Company ? true : false),
          menuItem(4, "Request", Icons.weekend_outlined, currentPage == DrawerSelection.Request ? true : false),
          menuItem(5, "Notification", Icons.notifications_none, currentPage == DrawerSelection.Notification ? true : false),
          menuItem(6, "Reseller Agreement", Icons.access_time, currentPage == DrawerSelection.ResellerAgreement ? true : false),
          menuItem(7, "Logout", Icons.logout, currentPage == DrawerSelection.Logout ? true : false),
          const Padding(
            padding: EdgeInsets.only(top: 250.0, right: 16, bottom: 16),
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
              currentPage = DrawerSelection.AddAgent;
            } else if (id == 3) {
              currentPage = DrawerSelection.Company;
            } else if (id == 4) {
              currentPage = DrawerSelection.Request;
            } else if (id == 5) {
              currentPage = DrawerSelection.Notification;
            } else if (id == 6) {
              currentPage = DrawerSelection.ResellerAgreement;
            } else if (id == 7) {
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
}

enum DrawerSelection { Dashboard, AddAgent, Company, Request, Notification, ResellerAgreement, Logout }
