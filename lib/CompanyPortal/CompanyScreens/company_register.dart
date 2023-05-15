import 'dart:io';
import 'package:etsemployee/Controller/CompanyController/company_registration_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CompanyRegistration extends StatefulWidget {
  const CompanyRegistration({Key? key}) : super(key: key);

  @override
  State<CompanyRegistration> createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  CompanyRegistrationController companyRegistrationController = CompanyRegistrationController();
  String companyProfileUrl = "";

  Future pickImage({bool gallery = true}) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) {
        setState(() {
          companyProfileUrl = "";
        });
      } else {
        setState(() {
          File imageFile = File(image.path);
          companyProfileUrl = imageFile.path;
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
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
                  onTap: () async {
                    await showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 150,
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await pickImage(gallery: true);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                                  child: const Center(
                                    child: Text(
                                      'Pick Image from Gallery',
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await pickImage(gallery: false);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                                  child: const Center(
                                    child: Text(
                                      'Pick Image from Camera',
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: companyProfileUrl.isEmpty
                            ? const CircleAvatar(
                                radius: 80.0,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/etslogo.png'),
                              )
                            : CircleAvatar(
                                radius: 80.0,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(File(companyProfileUrl)),
                              ),
                      ),
                    ),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: companyRegistrationController.creditCardExp,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Expiry Date',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (companyRegistrationController.companyName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, companyName required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.contactPerson.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, ContactPerson required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.address.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, address required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.city.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, City required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.state.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, State required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.zip.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, ZipCode required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.creditCardNumber.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, CreditCard Number required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.creditCardName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, CreditCardName required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.creditCardExp.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, ExpiryDate required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.securityCode.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, securityCode  required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, email required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyRegistrationController.phone.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Phone Number required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (companyProfileUrl.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops,Please select logo From Gallery !"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        companyRegistrationController.companyRegister(context, companyProfileUrl);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
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
