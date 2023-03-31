import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../Controller/CompanyController/comapny_delete_contact_controller.dart';
import '../../../Controller/CompanyController/company_contact_controller.dart';
import '../../../Models/CompanyModels/company_contacts_model.dart';
import '../../../Models/CompanyModels/company_delete_contact_model.dart';
import '../../../utils/Colors.dart';
import 'add_company_contcat.dart';
import 'edit_company_contcat.dart';

class ManageCompanyContact extends StatefulWidget {
  const ManageCompanyContact({Key? key}) : super(key: key);

  @override
  State<ManageCompanyContact> createState() => _ManageCompanyContactState();
}

class _ManageCompanyContactState extends State<ManageCompanyContact> {
  CompanyContactController commonCompanyController = CompanyContactController();
  late CompanyContactModel companyContactModel;
  List<ListElement> contactList = [];

  CompanyDeleteContactController deleteContactController =
      CompanyDeleteContactController();
  late CompanyDeleteContactModel deleteContactModel;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    commonCompanyController.getCompanyContact(context).then((value) {
      setState(() {
        companyContactModel = value;
        contactList = companyContactModel.data.list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Manage Contacts",
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
            child: Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: appThemeGreen,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddCompanyContact()));
                          },
                          child: const Text(
                            'Add New Contact',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      var detail = contactList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                              child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    child: Image.asset(
                                      'assets/man.jpeg',
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.firstName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        detail.companyName,
                                        style: TextStyle(
                                            fontSize: 14, color: colorTextGray),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        detail.address,
                                        style: TextStyle(
                                            fontSize: 14, color: colorTextGray),
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
                                            detail.email,
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
                                            "Office/House No: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            detail.homeOrOfficeNo,
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
                                            "Mobile No: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            detail.mobileNo,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: colorTextGray),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        detail.customerType,
                                        style: TextStyle(
                                            fontSize: 14, color: colorTextGray),
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
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditCompanyContact()));
                                              },
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
                                          const SizedBox(
                                            width: 1,
                                            height: 35,
                                            child: const DecoratedBox(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                deleteContactController
                                                    .deleteContact(
                                                        context, detail.id)
                                                    .then((value) {
                                                  deleteContactModel = value;
                                                  print(deleteContactModel
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
                                      )),
                                ),
                              ],
                            ),
                          )),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
