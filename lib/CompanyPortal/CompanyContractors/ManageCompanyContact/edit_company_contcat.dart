// ignore_for_file: must_be_immutable

import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/CompanyController/company_add_contact_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_edit_contact_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Controller/CompanyController/company_add_contact_controller.dart';
import '../../../Controller/CompanyController/company_edit_contact_controller.dart';
import '../../../Network/api_constant.dart';

class EditCompanyContact extends StatefulWidget {
  EditCompanyContact(
      {required this.callback,
      required this.id,
      required this.customerType,
      required this.fistName,
      required this.laseName,
      required this.companyName,
      required this.address,
      required this.city,
      required this.state,
      required this.zipCode,
      required this.email,
      required this.homeNo,
      required this.mobileNo,
      Key? key})
      : super(key: key);

  String id;
  String customerType;
  String fistName;
  String laseName;
  String companyName;
  String address;
  String city;
  String state;
  String zipCode;
  String email;
  String homeNo;
  String mobileNo;
  final VoidCallback callback;

  @override
  State<EditCompanyContact> createState() => _EditCompanyContactState();
}

class _EditCompanyContactState extends State<EditCompanyContact> {
  CompanyAddContactController addCompanyContactController =
      CompanyAddContactController();
  CompanyEditContactController editContactController =
      CompanyEditContactController();
  String selectedCustomerType = "Select Customer Type";
  List<DropdownMenuItem<Object?>> customerListItems = [];

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      selectedCustomerType = selectedTest['Type'];
      editContactController.customerType.text = selectedTest['key'].toString();

      debugPrint(selectedTest['key'].toString());
    });
  }

  bool _isValidEmail(String email) {
    //final gmailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$');
    final gmailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return gmailRegExp.hasMatch(email);
  }

  List<DropdownMenuItem<Object?>> buildTaskSizeListItems(xyz) {
    List<DropdownMenuItem<Object?>> items = [];
    items.clear();
    for (var i in xyz) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['Type'],
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    editContactController.customerType.text = widget.customerType;
    editContactController.firstName.text = widget.fistName;
    editContactController.laseName.text = widget.laseName;
    editContactController.companyName.text = widget.companyName;
    editContactController.address.text = widget.address;
    editContactController.city.text = widget.city;
    editContactController.state.text = widget.state;
    editContactController.zipCode.text = widget.zipCode;
    editContactController.email.text = widget.email;
    editContactController.homeNo.text = widget.homeNo;
    editContactController.mobileNo.text = widget.mobileNo;

    Future.delayed(const Duration(microseconds: 0), () {
      addCompanyContactController
          .getCustomerTypeForContact(context)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      customerListItems = buildTaskSizeListItems(value);
                      for (int i = 0; i < value.length; i++) {
                        if (value[i]["key"].toString() == widget.customerType) {
                          editContactController.customerType.text =
                              value[i]["key"].toString();
                          selectedCustomerType = value[i]["Type"];
                        }
                      }
                    }),
                  }
                else
                  {
                    setState(() {
                      customerListItems.clear();
                    }),
                  }
              });
    });
    debugPrint(widget.customerType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Edit Contacts",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ApiConstant.profileImage.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(ApiConstant.profileImage),
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
              widget.callback();
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Customer Type *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DropdownBelow(
                          itemWidth: MediaQuery.of(context).size.width - 30,
                          itemTextstyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          boxTextstyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          boxWidth: MediaQuery.of(context).size.width,
                          boxHeight: 40,
                          boxDecoration: BoxDecoration(
                            color: colorScreenBg,
                            border: Border.all(color: colorGray, width: 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7.0)),
                          ),
                          boxPadding: const EdgeInsets.only(
                              left: 12, top: 6, bottom: 6, right: 10),
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: appThemeGreen,
                          ),
                          hint: Text(
                            selectedCustomerType,
                            style: TextStyle(
                                fontSize: 18,
                                color: selectedCustomerType ==
                                        "Select Customer Type"
                                    ? Colors.black.withOpacity(0.60)
                                    : Colors.black),
                          ),
                          onChanged: onChangeDropdownBoxSize,
                          items: customerListItems),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "First Name *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.firstName,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/profile1.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter first name',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Last Name *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.laseName,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/profile1.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter last name',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                      //   child: Text(
                      //     "Company Name *",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      //   child: TextField(
                      //     controller: editContactController.companyName,
                      //     style: const TextStyle(fontSize: 18, color: Colors.black),
                      //     maxLines: 1,
                      //     decoration: InputDecoration(
                      //       suffixIcon: Align(
                      //           widthFactor: 1,
                      //           heightFactor: 1,
                      //           child: ImageIcon(
                      //             const AssetImage('assets/company.png'),
                      //             color: appThemeGreen,
                      //           )),
                      //       hintText: 'Enter company name',
                      //       fillColor: colorScreenBg,
                      //       filled: true,
                      //       isDense: true,
                      //       contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      //       enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: colorGray, width: 1.0),
                      //         borderRadius: BorderRadius.circular(7),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Address *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.address,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter address',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "City *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.city,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter city',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "State *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.state,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter state',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Zip Code *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.zipCode,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/location.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter zip code',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Email *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.email,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/message.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter email id',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Home/Office No *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.homeNo,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/call.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter home/office number',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Mobile No *",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: editContactController.mobileNo,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: ImageIcon(
                                  const AssetImage('assets/call.png'),
                                  color: appThemeGreen,
                                )),
                            hintText: 'Enter mobile number',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6),
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
                          onTap: () async {
                            if (selectedCustomerType.isEmpty ||
                                editContactController
                                    .customerType.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Oops!, Please select customer type from list."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .firstName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, First name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .laseName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Last name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .address.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Address missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .city.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, City name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .state.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, State name missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .zipCode.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Zipcode missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (editContactController
                                .email.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, Email missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (!_isValidEmail(
                                editContactController.email.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops, Invalid Email format!"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                            // else if (editContactController.homeNo.text.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text("Oops!, Home/Office number missing."),
                            //       duration: Duration(seconds: 1),
                            //     ),
                            //   );
                            // }
                            else if (editContactController
                                .mobileNo.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Oops!, Mobile number missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              await editContactController
                                  .editContact(context, widget.id)
                                  .then((value) {
                                setState(() {
                                  widget.callback();
                                  Navigator.pop(context);
                                });
                              });
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
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
