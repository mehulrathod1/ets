import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../utils/Colors.dart';
import '../ManageAgent/add_sales_agent_company.dart';
import 'add_existing_company.dart';

class ManageSalesCompany extends StatefulWidget {
  const ManageSalesCompany({Key? key}) : super(key: key);

  @override
  State<ManageSalesCompany> createState() => _ManageSalesCompanyState();
}

class _ManageSalesCompanyState extends State<ManageSalesCompany> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                            height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: appThemeGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: colorred,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Clear Filter',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: appThemeBlue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddExistingCompany()));
                      },
                      child: Text(
                        'Add Existing Company',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: appThemeBlue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddSalesAgentCompany()));
                      },
                      child: Text(
                        'Add Sales Company',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total No Of Company is ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "7",
                    style: TextStyle(fontSize: 14, color: appThemeBlue),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total No Employee is  ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "42",
                    style: TextStyle(fontSize: 14, color: appThemeBlue),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Email: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "TestAgent@gmail.com",
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
                                          "Phone: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "9876543210",
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
                                          "Total No. Of Employee: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "20",
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
                                          "Subscription Price: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '20',
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
                                          "Company is Under: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Agent",
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
                                          "Active: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.done, color: appThemeGreen)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Joining Date: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "12-15-2022",
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
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             EditAttendanceList()));
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: appThemeGreen,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(15))),
                                            height: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    "View Employee List",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
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
