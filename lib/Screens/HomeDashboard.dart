// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names, constant_identifier_names, file_names

import 'package:etsemployee/CommonWidget/my_drawer_header.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_profile_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_profile_details_model.dart';
import 'package:etsemployee/Screens/Contractors/ManageProfile/profile_screen.dart';
import 'package:etsemployee/Screens/UserSelectionScreen.dart';
import 'package:etsemployee/Screens/Contractors/contractorts_screen.dart';
import 'package:etsemployee/Screens/history_screen.dart';
import 'package:etsemployee/Screens/hour_request.dart';
import 'package:etsemployee/Screens/privacy_policy.dart';
import 'package:etsemployee/Screens/share_location.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/EmployeeController/employee_notification_controller.dart';
import '../Models/EmployeeModel/employee_notification_model.dart';
import '../Network/api_constant.dart';
import 'attendanceScreen.dart';
import 'Home.dart';
import 'message_screen.dart';
import 'notification_screen.dart';

class HomeDashboard extends StatefulWidget {
  final int? currentTableSelected;
  const HomeDashboard({
    Key? key,
    this.currentTableSelected,
  }) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboard();
}

class _HomeDashboard extends State<HomeDashboard> {
  EmployeeProfileController employeeProfileController =
      EmployeeProfileController();
  EmployeeProfileDetailsModel? employeeProfileDetailsModel;
  bool loading = false;
  var currentPage = DrawerSelection.Dashboard;
  var container;
  //int _selectedIndex = 0;
  String appBarTitle = "";

  int unread_notification = 1;
  Map<int, int> notificationCounts =
      {}; // Initialize the notificationCounts map here
  EmployeeNotificationController notificationController =
      EmployeeNotificationController();
  late EmployeeNotificationModel notificationModel;

  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserSelectionScreen()),
        (route) => false);
  }

  Future getNotification(BuildContext context) async {
    await notificationController.getNotification(context).then((value) {
      setState(() {
        notificationModel = value;
        unread_notification = notificationModel.data.unreadNotification;
        print(
            "editOrder response :- ${notificationModel.data.unreadNotification}");

        notificationCounts = {
          7: unread_notification, // For menu item 5 (Notification), there is 1 notification
          // Add notification counts for other menu items if needed
        };
        debugPrint(value.message);
      });
    });
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
        setState(() {
          notificationCounts = {
            7: 0,
          }; // For menu item 5 (Notification), there is 1 notification
          // Add notification counts for other menu items if needed
        });
      } else if (_selectedIndex == 4) {
        currentPage = DrawerSelection.Profile;
      }
    });
  }

  void changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        currentPage = DrawerSelection.ShareLocation;
        // _selectedIndex == 0;
        setState(() {});
      } else if (index == 1) {
        currentPage = DrawerSelection.History;
        // _selectedIndex == 1;
        setState(() {});
      } else if (index == 2) {
        currentPage = DrawerSelection.Attendance;
        // _selectedIndex == 3;
        setState(() {});
      } else if (index == 3) {
        currentPage = DrawerSelection.ContractorsBackOffice;
        // _selectedIndex == 0;
        setState(() {});
      } else if (index == 4) {
        currentPage = DrawerSelection.Profile;
        // _selectedIndex == 3;
        setState(() {});
      }

      // else if (index == 2) {
      //   currentPage = DrawerSelection.ShareLocation;
      //   _selectedIndex == 2;
      //   setState(() {});
      // } else if (index == 3) {
      //   currentPage = DrawerSelection.Notification;
      //   _selectedIndex == 3;
      //   setState(() {});
      // }
      // else if (index == 5) {
      //   currentPage = DrawerSelection.ShareLocationScreen;
      //   _selectedIndex == 4;
      //   setState(() {});
      // } else if (index == 6) {
      //   currentPage = DrawerSelection.AttendanceScreen;
      //   // _selectedIndex == 4;
      //   setState(() {});
      // } else if (index == 7) {
      //   currentPage = DrawerSelection.ViewHourRequest;
      //   _selectedIndex == 4;
      //   setState(() {});
      // } else if (index == 8) {
      //   currentPage = DrawerSelection.ContractorsBackOffice;
      //   _selectedIndex == 4;
      //   setState(() {});
      // } else if (index == 9) {
      //   currentPage = DrawerSelection.Message;
      //   _selectedIndex == 4;
      //   setState(() {});
      // }
    });
  }

  Widget MyDrawerList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          menuItem(
            1,
            "Dashboard",
            Icons.grid_view_outlined,
            currentPage == DrawerSelection.Dashboard ? true : false,
          ),
          menuItem(2, "Attendance", Icons.check_circle_outline,
              currentPage == DrawerSelection.Attendance ? true : false),
          menuItem(3, "Fix Hours Request", Icons.access_time_outlined,
              currentPage == DrawerSelection.FixHoursRequest ? true : false),
          menuItem(4, "Share Location", Icons.location_on_outlined,
              currentPage == DrawerSelection.ShareLocation ? true : false),
          menuItem(5, "History", Icons.refresh_outlined,
              currentPage == DrawerSelection.History ? true : false),
          menuItem(6, "Message", Icons.sms_outlined,
              currentPage == DrawerSelection.Message ? true : false),
          menuItem(7, "Notification", Icons.notifications_none,
              currentPage == DrawerSelection.Notification ? true : false),
          menuItem(
              8,
              "Contractors Back Office",
              Icons.work_outline,
              currentPage == DrawerSelection.ContractorsBackOffice
                  ? true
                  : false),
          menuItem(9, "Privacy Policy", Icons.help_outline,
              currentPage == DrawerSelection.Howitworks ? true : false),
          menuItem(10, "Logout", Icons.logout,
              currentPage == DrawerSelection.Logout ? true : false),
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
    int notificationCount = notificationCounts[id] ?? 0;
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);

          setState(() {
            if (id == 1) {
              currentPage = DrawerSelection.Dashboard;
              _selectedIndex = 0;
              setState(() {});
            } else if (id == 2) {
              currentPage = DrawerSelection.Attendance;
              _selectedIndex = 0;
              setState(() {});
            } else if (id == 3) {
              currentPage = DrawerSelection.FixHoursRequest;
              _selectedIndex = 0;
              setState(() {});
            } else if (id == 4) {
              currentPage = DrawerSelection.ShareLocation;
              _selectedIndex = 2;
              setState(() {});
            } else if (id == 5) {
              currentPage = DrawerSelection.History;
            } else if (id == 6) {
              currentPage = DrawerSelection.Message;
              _selectedIndex = 1;
              setState(() {});
            } else if (id == 7) {
              setState(() {
                notificationCounts = {
                  7: 0, // For menu item 5 (Notification), there is 1 notification
                  // Add notification counts for other menu items if needed
                };
              });
              currentPage = DrawerSelection.Notification;
              _selectedIndex = 3;
            } else if (id == 8) {
              currentPage = DrawerSelection.ContractorsBackOffice;
              _selectedIndex = 0;
              setState(() {});
            } else if (id == 9) {
              currentPage = DrawerSelection.Howitworks;
              _selectedIndex = 0;
              setState(() {});
            } else if (id == 10) {
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
                child: Stack(
                  // Use a Stack to overlay the notification text
                  alignment: Alignment.topLeft,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: selected ? appThemeGreen : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    if (notificationCount >
                        0) // Show the notification count if it's greater than 0
                      Positioned(
                        top: 0,
                        right: 6,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors
                                .red, // Customize the notification badge color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            notificationCount.toString(),
                            style: TextStyle(
                              color: Colors
                                  .white, // Customize the notification text color
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.all(8),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Icon(
        //           icon,
        //           size: 24,
        //           color: selected ? appThemeGreen : Colors.black,
        //         ),
        //       ),
        //       Expanded(
        //         flex: 6,
        //         child: Text(
        //           title,
        //           style: TextStyle(
        //               color: selected ? appThemeGreen : Colors.black,
        //               fontSize: 16),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await employeeProfileController.getEmployeeProfile(context).then((value) {
      setState(() {
        if (value != null) {
          employeeProfileDetailsModel = value;
          ApiConstant.profileImage =
              employeeProfileDetailsModel!.data.profileImg;
          loading = false;
        } else {
          loading = false;
        }
      });
    });

    // employeeProfileDetailsModel!.data.profileImg = '';
    if (employeeProfileDetailsModel!.data.profileImg == '') {
      print('employeeProfileDetailsModel!.data.profileImg');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(
                    appBar: true,
                  )));
    } else {
      print(employeeProfileDetailsModel!.data.profileImg);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          "profilePic", employeeProfileDetailsModel!.data.profileImg);
    }
  }

  @override
  void initState() {
    initialize(context);
    getNotification(context);
    setState(() {
      _selectedIndex = widget.currentTableSelected!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentPage == DrawerSelection.Dashboard) {
      container = Home(changeScreen: changeScreen);
      appBarTitle = "Dashboard";
    } else if (currentPage == DrawerSelection.Attendance) {
      container = AttendanceScreen(
        appBar: false,
      );
      appBarTitle = "Attendance";
    } else if (currentPage == DrawerSelection.FixHoursRequest) {
      container = const HourRequest();
      appBarTitle = "Hours Request";
    } else if (currentPage == DrawerSelection.ShareLocation) {
      container = ShareLocationScreen(
        appBar: false,
      );
      appBarTitle = "Share Location";
    } else if (currentPage == DrawerSelection.History) {
      container = const HistoryScreen();
      appBarTitle = "History";
    } else if (currentPage == DrawerSelection.Message) {
      container = MessageScreen(
        appBar: false,
      );
      appBarTitle = "Message";
    } else if (currentPage == DrawerSelection.Notification) {
      container = NotificationScreen();
      appBarTitle = "Notification";
    } else if (currentPage == DrawerSelection.ContractorsBackOffice) {
      container = ContractorsScreen(
          profilePic: employeeProfileDetailsModel!.data.profileImg);
      appBarTitle = "Contractors Back Office";
    } else if (currentPage == DrawerSelection.Howitworks) {
      container = EmployeePrivacyPolicy();
      appBarTitle = "Privacy Policy";
    } else if (currentPage == DrawerSelection.Profile) {
      container = Profile(
        changeScreen: changeScreen,
        appBar: false,
      );
      appBarTitle = "Profile";
    } else if (currentPage == DrawerSelection.Logout) {
      navigate();
    }
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: Center(
                child: Text(appBarTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: employeeProfileDetailsModel!.data.profileImg.isEmpty
                      ? const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        )
                      : CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              employeeProfileDetailsModel!.data.profileImg),
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

                    setState(() {});
                  },
                );
              }),
            ),
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyDrawerHeader(
                        userName: employeeProfileDetailsModel!.data.username,
                        email: employeeProfileDetailsModel!.data.email,
                        profilePicture:
                            employeeProfileDetailsModel!.data.profileImg),
                    MyDrawerList()
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: colorScreenBg,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
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
            body: container,
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
  Logout,
  Profile,
  ShareLocationScreen,
  AttendanceScreen,
  ViewHourRequest
}

int _selectedIndex = 0;
