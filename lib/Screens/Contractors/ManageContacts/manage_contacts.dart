// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:etsemployee/CompanyPortal/CompanyContractors/company_contractors_screen.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_contact_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_contact_model.dart';
import 'package:etsemployee/Screens/Contractors/ManageContacts/add_new_contact.dart';
import 'package:etsemployee/Screens/Contractors/ManageContacts/edit_contact.dart';
import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../CompanyPortal/PopUps/delete_conformation_popup.dart';

class ManageContactScreen extends StatefulWidget {
  ManageContactScreen({Key? key, this.profilePic}) : super(key: key);
  String? profilePic;

  @override
  State<ManageContactScreen> createState() => _ManageContactScreenState();
}

class _ManageContactScreenState extends State<ManageContactScreen>
    with WidgetsBindingObserver {
  bool loading = false;
  EmployeeContactController employeeContactController =
      EmployeeContactController();
  late EmployeeContactModel employeeContactModel;
  List<ListElement> contactList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    initialize(context, '');
  }

  void refreshData() {
    setState(() {
      initialize(context, '');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this); // Add this line
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      initialize(context, '');
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive

    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally

    }
    super.didChangeAppLifecycleState(state);
  }

  Future initialize(BuildContext context, String search) async {
    setState(() {
      loading = true;
    });
    await employeeContactController
        .getEmployeeContact(context, search: search, page: 1)
        .then((value) {
      setState(() {
        if (value != null) {
          employeeContactModel = value;
          contactList = employeeContactModel.data.list;
          loading = false;
        } else {
          contactList.clear();
          loading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
            child: Text("Manage Contacts",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black))),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: widget.profilePic!.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(widget.profilePic!),
                  ),
          ),
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyContractorsScreen()));
            },
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                textInputAction: TextInputAction.search,
                style: const TextStyle(fontSize: 18, color: Colors.black),
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
                onSubmitted: (value) {
                  print(loading);
                  initialize(context, value);
                },
                onChanged: (value) {
                  initialize(context, value);
                },
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
                              builder: (context) => AddNewContact(
                                    callback: () {
                                      refreshData();
                                    },
                                  )));
                    },
                    child: const Text(
                      'Add New Contact',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : contactList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: contactList.length,
                            itemBuilder: (context, index) {
                              var detail = contactList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                detail.firstName +
                                                    " " +
                                                    detail.lastName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                detail.companyName,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                detail.address,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Email: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    detail.email,
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
                                                    "Office/House No: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    detail.homeOrOfficeNo,
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
                                                    "Mobile No: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    detail.mobileNo,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: colorTextGray),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                detail.customerType,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: appThemeBlue,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(15),
                                                        bottomRight:
                                                            Radius.circular(
                                                                15))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditContact(
                                                            id: detail.id,
                                                            customerType: detail
                                                                .customerType,
                                                            firstName: detail
                                                                .firstName,
                                                            lastName:
                                                                detail.lastName,
                                                            companyName: detail
                                                                .companyName,
                                                            address:
                                                                detail.address,
                                                            city: detail.city,
                                                            state: detail.state,
                                                            zipcode:
                                                                detail.zipcode,
                                                            email: detail.email,
                                                            homeNumber: detail
                                                                .homeOrOfficeNo,
                                                            mobileNumber:
                                                                detail.mobileNo,
                                                            callback: () {
                                                              refreshData();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            "View/Edit",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 1,
                                                  height: 35,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    // onTap: () async {
                                                    //   await employeeContactController
                                                    //       .employeeDeleteContact(
                                                    //           context: context,
                                                    //           id: detail.id)
                                                    //       .then((value) {
                                                    //     if (value) {
                                                    //       initialize(
                                                    //           context, '');
                                                    //     }
                                                    //   });
                                                    // },

                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return ConfirmationPopup(
                                                            title:
                                                                'Confirmation',
                                                            message:
                                                                'Are you sure you want to delete?',
                                                            onConfirm:
                                                                () async {
                                                              await employeeContactController
                                                                  .employeeDeleteContact(
                                                                      context:
                                                                          context,
                                                                      id: detail
                                                                          .id)
                                                                  .then(
                                                                      (value) {
                                                                if (value) {
                                                                  initialize(
                                                                      context,
                                                                      '');
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              });
                                                              // Close the dialog
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: colorred,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15))),
                                                      height: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
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
                            }),
                      )
                    : const Text(
                        'Oops No Contact Found!',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
          ],
        ),
      ),
    );
  }
}
