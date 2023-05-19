import 'dart:io';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/SalesController/agency_register_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SalesSignUp extends StatefulWidget {
  const SalesSignUp({Key? key}) : super(key: key);

  @override
  State<SalesSignUp> createState() => _SalesSignUpState();
}

class _SalesSignUpState extends State<SalesSignUp> {
  String selectedRole = "Select Role";
  List<DropdownMenuItem<Object?>> taskOrderListItems = [];
  List roleList = [
    {'no': '1', 'keyword': 'Agency'},
    {'no': '2', 'keyword': 'Agent'},
  ];
  AgencyRegisterController agencyRegisterController = AgencyRegisterController();
  String salesProfileUrl = "";

  Future pickImage({bool gallery = true}) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) {
        setState(() {
          salesProfileUrl = "";
        });
      } else {
        setState(() {
          File imageFile = File(image.path);
          salesProfileUrl = imageFile.path;
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      agencyRegisterController.role.text = selectedTest['no'];
      selectedRole = selectedTest['keyword'];
      debugPrint(agencyRegisterController.role.text);
    });
  }

  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List roleList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in roleList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest) {
    debugPrint(selectedTest);
    setState(() {
      selectedRole = selectedTest;
    });
  }

  @override
  void initState() {
    taskOrderListItems = buildDropdownTestItems(roleList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Sales Registration",
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
                        child: salesProfileUrl.isEmpty
                            ? const CircleAvatar(
                                radius: 80.0,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/etslogo.png'),
                              )
                            : CircleAvatar(
                                radius: 80.0,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(File(salesProfileUrl)),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: agencyRegisterController.name,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter UserName',
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
                    controller: agencyRegisterController.address,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter Address',
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
                    controller: agencyRegisterController.city,
                    style: const TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter city ',
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
                    controller: agencyRegisterController.state,
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
                    controller: agencyRegisterController.zip,
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
                    controller: agencyRegisterController.email,
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
                    controller: agencyRegisterController.phone,
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
                  child: DropdownBelow(
                      itemWidth: MediaQuery.of(context).size.width - 30,
                      itemTextstyle: const TextStyle(fontSize: 18, color: Colors.black),
                      boxTextstyle: const TextStyle(fontSize: 18, color: Colors.black),
                      boxWidth: MediaQuery.of(context).size.width,
                      boxHeight: 40,
                      boxDecoration: BoxDecoration(
                        color: colorScreenBg,
                        border: Border.all(color: colorGray, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                      ),
                      boxPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 10),
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: appThemeGreen,
                      ),
                      hint: Text(
                        selectedRole,
                        style: TextStyle(fontSize: 18, color: selectedRole == "Test Order Section" ? Colors.black.withOpacity(0.60) : Colors.black),
                      ),
                      onChanged: onChangeDropdownBoxSize,
                      items: taskOrderListItems),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (agencyRegisterController.name.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, name required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (agencyRegisterController.address.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Address required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (agencyRegisterController.city.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, City required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (agencyRegisterController.zip.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Zip Code required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (agencyRegisterController.email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Email required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (agencyRegisterController.phone.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Phone No required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (agencyRegisterController.address.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, Address required!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (selectedRole == 'Select Role') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops,Please select role!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (salesProfileUrl.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops,Please select logo From Gallery !"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        agencyRegisterController.agencyRegister(context, salesProfileUrl);
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
