import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';

import '../../../Controller/EmployeeController/employee_add_contact_controller.dart';
import '../../../Models/CompanyModels/company_add_contcat_model.dart';
import '../../../utils/Colors.dart';

class AddNewContact extends StatefulWidget {
  const AddNewContact({Key? key}) : super(key: key);

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  EmployeeAddContactController employeeAddContactController =
      EmployeeAddContactController();
  late EmployeeAddContactModel employeeAddContactModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Add Contacts",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
            ),
          ),
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: SingleChildScrollView(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Customer Type *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.customerType,
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
                            hintText: 'Customer',
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
                          "First Name *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.firstName,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/profile1.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter first name',
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
                          "Last Name *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.lastName,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/profile1.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter last name',
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
                          "Company Name *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.companyName,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/company.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter company name',
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
                          "Address *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.address,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter address',
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
                          "City *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.city,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter city',
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
                          "State *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.state,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter state',
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
                          "Zip Code *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: employeeAddContactController.zipcode,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter zip code',
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
                          "Email *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.email,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/message.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter email id',
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
                          "Home/Office No *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: employeeAddContactController.homeNumber,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/call.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter home/office number',
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
                          "Mobile No *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: employeeAddContactController.mobileNumber,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  AssetImage('assets/call.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter mobile number',
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
                            employeeAddContactController
                                .addContact(context)
                                .then((value) {
                              employeeAddContactModel = value;
                              print(employeeAddContactModel.message);
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
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
