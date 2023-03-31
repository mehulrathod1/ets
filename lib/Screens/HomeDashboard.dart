import 'package:etsemployee/Screens/SignIn.dart';
import 'package:etsemployee/Screens/Splash.dart';
import 'package:etsemployee/Screens/UserSelectionScreen.dart';
import 'package:etsemployee/Screens/Contractors/contractorts_screen.dart';
import 'package:etsemployee/Screens/history_screen.dart';
import 'package:etsemployee/Screens/hour_request.dart';
import 'package:etsemployee/Screens/share_location.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CommonWidget/my_drawer_header.dart';
import 'AttendanceScreen.dart';
import 'Contractors/ManageProfile/profile_screen.dart';
import 'Home.dart';
import 'message_screen.dart';
import 'notification_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboard();
}

class _HomeDashboard extends State<HomeDashboard> {
  var currentPage = DrawerSelection.Dashboard;
  int _selectedIndex = 0;
  String appBarTitle = "";
  List<Widget> screens = [
    Home(),
    AttendanceScreen(),
    Home(),
    Home(),
    Home(),
  ];
  var container;

  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserSelectionScreen()),
        (route) => false);

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (currentPage == DrawerSelection.Dashboard) {
      container = Home();
      appBarTitle = "Dashboard";
    } else if (currentPage == DrawerSelection.Attendance) {
      container = AttendanceScreen();
      appBarTitle = "Attendance";
    } else if (currentPage == DrawerSelection.FixHoursRequest) {
      container = HourRequest();
      appBarTitle = "Hours Request";
    } else if (currentPage == DrawerSelection.ShareLocation) {
      container = ShareLocationScreen();
      appBarTitle = "Share Location";
    } else if (currentPage == DrawerSelection.History) {
      container = HistoryScreen();
      appBarTitle = "History";
    } else if (currentPage == DrawerSelection.Message) {
      container = MessageScreen();
      appBarTitle = "Message";
    } else if (currentPage == DrawerSelection.Notification) {
      container = NotificationScreen();
      appBarTitle = "Notification";
    } else if (currentPage == DrawerSelection.ContractorsBackOffice) {
      container = ContractorsScreen();
      appBarTitle = "Contractors Back Office";
    } else if (currentPage == DrawerSelection.Logout) {
      navigate();
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorScreenBg,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title: Center(
            child: Text(appBarTitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/man.jpeg'),
              ),
            ),
          ],
          leading: Builder(builder: (context) {
            return GestureDetector(
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
        // drawer: Drawer(
        //   child: Stack(
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: [
        //           Container(
        //             child: Padding(
        //               padding: const EdgeInsets.only(top: 50.0, left: 8),
        //               child: Align(
        //                   alignment: Alignment.topLeft,
        //                   child: Image.asset('assets/desktop_logo.png')),
        //             ),
        //           ),
        //           Padding(
        //             padding:
        //                 const EdgeInsets.only(left: 8.0, top: 40, bottom: 10),
        //             child: Container(
        //               child: Row(
        //                 children: [
        //                   CircleAvatar(
        //                     radius: 20,
        //                     backgroundImage: AssetImage('assets/etslogo.png'),
        //                   ),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.only(left: 8.0),
        //                         child: Text('Username',
        //                             textAlign: TextAlign.left,
        //                             style: TextStyle(
        //                                 color: Colors.black, fontSize: 16)),
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.only(left: 8.0),
        //                         child: Text('crazycoder09@gmail.com',
        //                             textAlign: TextAlign.left,
        //                             style: TextStyle(
        //                                 color: appThemeGreen, fontSize: 10)),
        //                       ),
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.grid_view_outlined),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Dashboard",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.check_circle_outline),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Attendance",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.access_time_outlined),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Fix Hours Request",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.location_on_outlined),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Share Location",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.refresh_outlined),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "History",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.sms_outlined),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Message",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.notifications_none),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Notification",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.work_outline),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Contractors Back Office",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.help_outline),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "How it works",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.settings_outlined),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Settings",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Icon(Icons.logout),
        //                 GestureDetector(
        //                   onTap: () {},
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       "Logout",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 50.0, right: 16),
        //         child: Align(
        //           alignment: Alignment.topRight,
        //           child: GestureDetector(
        //             onTap: () {
        //               Navigator.pop(context);
        //             },
        //             child: Icon(
        //               Icons.close,
        //               color: Colors.black,
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 50.0, right: 16, bottom: 16),
        //         child: Align(
        //           alignment: Alignment.bottomCenter,
        //           child: Text(
        //             'Employee Tracking Solutions.\n Copyright © 2023 All Rights Reserved.',
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [MyDrawerHeader(), MyDrawerList()],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: colorScreenBg,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
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
        ),
        body: container
        // Center(
        //   child: Expanded(child: screens.elementAt(_selectedIndex)),
        // ),

        );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        currentPage = DrawerSelection.Dashboard;
      } else if (_selectedIndex == 1) {
        currentPage = DrawerSelection.Message;
      } else if (_selectedIndex == 2) {
        currentPage = DrawerSelection.ShareLocation;
      } else if (_selectedIndex == 3) {
        currentPage = DrawerSelection.Notification;
      } else if (_selectedIndex == 4) {
        currentPage = DrawerSelection.Dashboard;
      }
      // if (_selectedIndex == 0) {
      //   container = AttendanceScreen();
      // } else if (_selectedIndex == 1) {
      //   container = AttendanceScreen();
      // }
    });
  }

  Widget MyDrawerList() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            menuItem(1, "Dashboard", Icons.grid_view_outlined,
                currentPage == DrawerSelection.Dashboard ? true : false),
            menuItem(2, "Attendance", Icons.check_circle_outline,
                currentPage == DrawerSelection.Attendance ? true : false),
            menuItem(3, "FixHoursRequest", Icons.access_time_outlined,
                currentPage == DrawerSelection.FixHoursRequest ? true : false),
            menuItem(4, "ShareLocation", Icons.location_on_outlined,
                currentPage == DrawerSelection.ShareLocation ? true : false),
            menuItem(5, "History", Icons.refresh_outlined,
                currentPage == DrawerSelection.History ? true : false),
            menuItem(6, "Message", Icons.sms_outlined,
                currentPage == DrawerSelection.Message ? true : false),
            menuItem(7, "Notification", Icons.notifications_none,
                currentPage == DrawerSelection.Notification ? true : false),
            menuItem(
                8,
                "ContractorsBackOffice",
                Icons.work_outline,
                currentPage == DrawerSelection.ContractorsBackOffice
                    ? true
                    : false),
            menuItem(9, "Howitworks", Icons.help_outline,
                currentPage == DrawerSelection.Howitworks ? true : false),
            menuItem(10, "Settings", Icons.settings_outlined,
                currentPage == DrawerSelection.Settings ? true : false),
            menuItem(11, "Logout", Icons.logout,
                currentPage == DrawerSelection.Logout ? true : false),
            Padding(
              padding: const EdgeInsets.only(top: 100.0, right: 16, bottom: 16),
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
              currentPage = DrawerSelection.Attendance;
            } else if (id == 3) {
              currentPage = DrawerSelection.FixHoursRequest;
            } else if (id == 4) {
              currentPage = DrawerSelection.ShareLocation;
            } else if (id == 5) {
              currentPage = DrawerSelection.History;
            } else if (id == 6) {
              currentPage = DrawerSelection.Message;
            } else if (id == 7) {
              currentPage = DrawerSelection.Notification;
            } else if (id == 8) {
              currentPage = DrawerSelection.ContractorsBackOffice;
            } else if (id == 11) {
              currentPage = DrawerSelection.Logout;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 24,
                color: selected ? appThemeGreen : Colors.black,
              )),
              Expanded(
                  flex: 6,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: selected ? appThemeGreen : Colors.black,
                        fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSelection {
  Dashboard,
  Attendance,
  FixHoursRequest,
  ShareLocation,
  History,
  Message,
  Notification,
  ContractorsBackOffice,
  Howitworks,
  Settings,
  Logout
}
