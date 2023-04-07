import 'package:flutter/material.dart';
import '../../utils/Colors.dart';
import 'company_notification.dart';
import 'manage_approval.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onTap: () {},
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
                            // Image.asset('assets/noun-history.png'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "44",
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold),
                                ),
                                ImageIcon(
                                  AssetImage("assets/nounGroup.png"),
                                  size: 60,
                                ),
                              ],
                            ),
                            // Icon(
                            //   Icons.location_on_outlined,
                            //   size: 60,
                            // ),
                            SizedBox(height: 8),
                            Text("Employee(s)")
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
                      onTap: () {},
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
                            // Image.asset('assets/noun-history.png'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "4",
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold),
                                ),
                                ImageIcon(
                                  AssetImage("assets/department.png"),
                                  size: 60,
                                ),
                              ],
                            ),
                            // Icon(
                            //   Icons.location_on_outlined,
                            //   size: 60,
                            // ),
                            SizedBox(height: 8),
                            Text("Department(s)")
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
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: TabBar(
                tabs: [
                  Tab(
                      child: Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Tab(
                      child: Text('Approvals',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )))
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
              children: [
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
