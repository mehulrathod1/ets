import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:image_picker/image_picker.dart';
import '../../Controller/CompanyController/company_registration_controller.dart';

import '../../utils/Colors.dart';

class CompanyRegistration extends StatefulWidget {
  const CompanyRegistration({Key? key}) : super(key: key);

  @override
  State<CompanyRegistration> createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  CompanyRegistrationController companyRegistrationController =
      CompanyRegistrationController();
  XFile? image = null;
  String con = "";

  Future _imgFromGallery() async {
    var image2 = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    print(image2!.path);
    setState(() {
      image = image2;
      con = 'imageSelected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Company Registration",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: colorScreenBg,
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _imgFromGallery();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Center(
                                child: CircleAvatar(
                          radius: 80,
                          child: CircleAvatar(
                            radius: 80.0,
                            child: (image != null)
                                ? Image.file(
                                    File(image!.path),
                                    fit: BoxFit.fitHeight,
                                  )
                                : Image.asset('assets/etslogo.png'),
                            backgroundColor: Colors.white,
                          ),
                        )))),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.companyName,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter CompanyName',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.contactPerson,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Contact Person',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.address,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Address ',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.city,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter City',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.state,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter State',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.zip,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Zip Code',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.creditCardNumber,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Credit Card No',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.creditCardName,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Credit Card Name',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.creditCardExp,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Expiry Date',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.securityCode,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Security Code',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.email,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.phone,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DropdownBelow(
                //       itemWidth: MediaQuery.of(context).size.width - 30,
                //       itemTextstyle:
                //       const TextStyle(fontSize: 18, color: Colors.black),
                //       boxTextstyle:
                //       const TextStyle(fontSize: 18, color: Colors.black),
                //       boxWidth: MediaQuery.of(context).size.width,
                //       boxHeight: 40,
                //       boxDecoration: BoxDecoration(
                //         color: colorScreenBg,
                //         border: Border.all(color: colorGray, width: 1.0),
                //         borderRadius:
                //         const BorderRadius.all(Radius.circular(7.0)),
                //       ),
                //       boxPadding: const EdgeInsets.only(
                //           left: 12, top: 6, bottom: 6, right: 10),
                //       icon: Icon(
                //         Icons.keyboard_arrow_down_outlined,
                //         color: appThemeGreen,
                //       ),
                //       hint: Text(
                //         selectedRole,
                //         style: TextStyle(
                //             fontSize: 18,
                //             color: selectedRole == "Test Order Section"
                //                 ? Colors.black.withOpacity(0.60)
                //                 : Colors.black),
                //       ),
                //       onChanged: onChangeDropdownBoxSize,
                //       items: taskOrderListItems),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (companyRegistrationController
                          .companyName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, companyName required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .contactPerson.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, ContactPerson required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .address.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, address required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .city.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, City required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .state.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, State required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .zip.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, ZipCode required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .creditCardNumber.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, CreditCard Number required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .creditCardName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, CreditCardName required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .creditCardExp.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, ExpiryDate required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .securityCode.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, securityCode  required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, email required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController
                          .phone.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Phone Number required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (con == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Oops,Please select logo From Gallery !"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        companyRegistrationController.companyRegister(
                            context, image!.path);
                      }
                    },
                    // onTap: () {
                    //   if (agencyRegisterController.name.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, name required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (agencyRegisterController
                    //       .address.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, Address required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (agencyRegisterController.city.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, City required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (agencyRegisterController.zip.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, Zip Code required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (agencyRegisterController.email.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, Email required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (agencyRegisterController.phone.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, Phone No required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (agencyRegisterController
                    //       .address.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops, Address required!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else if (selectedRole == 'Select Role') {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text("Oops,Please select role!"),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   } else {
                    //     agencyRegisterController.agencyRegister(context);
                    //   }
                    // },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: appThemeGreen,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
