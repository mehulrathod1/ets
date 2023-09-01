import 'dart:convert';
import 'dart:io';
import 'package:etsemployee/Controller/CompanyController/company_registration_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_get_agency_list.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EmployeeName {
  final String name;

  EmployeeName(this.name);
}

class EmployeeEmail {
  final String email;

  EmployeeEmail(this.email);
}

class EmployeeList {
  late List<EmployeeName> employName;
  late List<EmployeeEmail> employeEmail;

  EmployeeList(this.employeEmail, this.employName);
}

class TotalEmployee {
  final String name;
  final String email;

  TotalEmployee(this.name, this.email);
}

class CompanyRegistration extends StatefulWidget {
  const CompanyRegistration({Key? key}) : super(key: key);

  @override
  State<CompanyRegistration> createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  CompanyRegistrationController companyRegistrationController =
      CompanyRegistrationController();
  String companyProfileUrl = "";
  List<EmployeeName> employeeListName = [];
  List<EmployeeEmail> employeeListEmail = [];
  List<TotalEmployee> totalEmployeeList = [];
  List<EmployeeList> employeeList = [];
  var dropdownvalue;
  List<Item> agencyList = [];

  TextEditingController employeeName = TextEditingController();
  TextEditingController employeeEmail = TextEditingController();

  void addEmployee() {
    setState(() {
      employeeListName.add(EmployeeName(employeeName.text));
      employeeListEmail.add(EmployeeEmail(employeeEmail.text));
      employeeList.add(EmployeeList(employeeListEmail, employeeListName));
    });
  }

  Future pickImage({bool gallery = true}) async {
    try {
      final image = await ImagePicker().pickImage(
          source: gallery ? ImageSource.gallery : ImageSource.camera);
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
  void initState() {
    // TODO: implement initState
    addEmployee();
    super.initState();
    callAgencyList(context);
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
          child: Column(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await pickImage(gallery: true);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: appThemeGreen,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                      child: Text(
                                        'Pick Image from Gallery',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
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
                                    decoration: BoxDecoration(
                                        color: appThemeBlue,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                      child: Text(
                                        'Pick Image from Camera',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
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
                              backgroundImage:
                                  FileImage(File(companyProfileUrl)),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                  // Add these formatters

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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16)
                  ],
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
                  keyboardType: TextInputType.text,
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
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('MM/yy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        companyRegistrationController.creditCardExp.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: companyRegistrationController.securityCode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  hint: Text('hooseNumber'),
                  items: agencyList.map((item) {
                    return DropdownMenuItem(
                      // value: item['ClassCode'].toString(),
                      child: Text(item.name),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      dropdownvalue = newVal;
                    });
                  },
                  value: dropdownvalue,
                ),
                // child: FutureBuilder<List<Item>>(
                //     future:
                //         companyRegistrationController.getAgencyList(context),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState ==
                //           ConnectionState.waiting) {
                //         return const CircularProgressIndicator();
                //       } else if (snapshot.hasError) {
                //         return Text('Error: ${snapshot.error}');
                //       } else {
                //         final items = snapshot.data!;
                //         return DropdownButton<Item>(
                //             items: items.map((item) {
                //               return DropdownMenuItem<Item>(
                //                 value: item,
                //                 child: Text(item.name),
                //               );
                //             }).toList(),
                //             onChanged: (selectedItem) {});
                //       }
                //     })
              ),
              // Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: FutureBuilder<List<Item>>(
              //         future:
              //             companyRegistrationController.getAgentList(context),
              //         builder: (context, snapshot) {
              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return CircularProgressIndicator();
              //           } else if (snapshot.hasError) {
              //             return Text('Error: ${snapshot.error}');
              //           } else {
              //             final items = snapshot.data!;
              //             return DropdownButton<Item>(
              //                 items: items.map((item) {
              //                   return DropdownMenuItem<Item>(
              //                     value: item,
              //                     child: Text(item.name),
              //                   );
              //                 }).toList(),
              //                 onChanged: (selectedItem) {});
              //           }
              //         })),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: employeeName,
                              style: const TextStyle(
                                  height: 1.7, color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                fillColor: colorTextField,
                                // hintText: 'Enter Employee Name',
                                filled: true,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12, top: 6, bottom: 6),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(7)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: employeeEmail,
                              style: const TextStyle(
                                  height: 1.7, color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                fillColor: colorTextField,
                                // hintText: 'Enter Employee Email',
                                filled: true,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12, top: 6, bottom: 6),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(7)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  employeeList.removeAt(index);
                                  employeeListEmail.removeAt(index);
                                  employeeListName.removeAt(index);
                                  print(index);
                                });
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    addEmployee();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: appThemeGreen,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Add Employee',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
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
                    } else if (companyRegistrationController.zip.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Oops, ZipCode required!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (companyRegistrationController.zip.text.length !=
                        6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Zip Code should be 6 digits long!"),
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
                            .creditCardNumber.text.length !=
                        16) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Oops,  CreditCard Number should be 16 digits long!"),
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
                            .securityCode.text.length !=
                        4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Oops,  Oops, securityCode should be 4 digits long!"),
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
                    } else if (companyRegistrationController
                            .phone.text.length !=
                        10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Oops,  Oops, Phone Number should be 10 digits long!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    // else if (companyProfileUrl.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text("Oops,Please select logo !"),
                    //       duration: Duration(seconds: 2),
                    //     ),
                    //   );
                    // }
                    else {
                      companyRegistrationController.companyRegister(
                          context, companyProfileUrl);

                      // companyRegistrationController
                      //     .companyRegisterWithoutLogo(context);

                      // companyRegistrationController.companyRegister(context,
                      //     companyProfilePic: File(companyProfileUrl));
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
    );
  }

  Future callAgencyList(BuildContext context) async {
    agencyList = await companyRegistrationController.getAgencyList(context);
  }
}
