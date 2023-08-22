import 'dart:async';
import 'dart:io';
import 'package:etsemployee/Controller/CompanyController/company_edit_profile_controller.dart';
import 'package:etsemployee/Controller/CompanyController/company_profile_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_profile_model.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CompanyEditProfile extends StatefulWidget {
  const CompanyEditProfile({Key? key}) : super(key: key);

  @override
  State<CompanyEditProfile> createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  CompanyUpdateProfileController updateProfileController =
      CompanyUpdateProfileController();
  CompanyProfileController companyProfileController =
      CompanyProfileController();
  late CompanyProfileModel companyProfileModel;
  TextEditingController expDate = TextEditingController();
  bool loading = false;
  String companyProfileUrl = "";

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
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyProfileController.getCompanyProfile(context).then((value) {
      setState(() {
        companyProfileModel = value;
        updateProfileController.name.text = companyProfileModel.data.username;
        updateProfileController.email.text = companyProfileModel.data.email;
        updateProfileController.companyName.text =
            companyProfileModel.data.companyName;
        updateProfileController.contactPerson.text =
            companyProfileModel.data.contactPerson;
        updateProfileController.phone.text = companyProfileModel.data.phone;
        updateProfileController.address.text = companyProfileModel.data.address;
        updateProfileController.city.text = companyProfileModel.data.city;
        updateProfileController.state.text = companyProfileModel.data.state;
        updateProfileController.zipCode.text = companyProfileModel.data.zip;
        updateProfileController.creditCardName.text =
            companyProfileModel.data.creditcardName;
        updateProfileController.creditCardNo.text =
            companyProfileModel.data.creditcardNo;
        updateProfileController.creditCardExp.text =
            companyProfileModel.data.creditcardExpDate;
        updateProfileController.securityCode.text =
            companyProfileModel.data.securityCode;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: colorScreenBg,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Center(
                child: Text("Edit Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: companyProfileModel.data.companyLogo.isEmpty
                      ? const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        )
                      : companyProfileUrl.isEmpty
                          ? CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                  companyProfileModel.data.companyLogo),
                            )
                          : CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  FileImage(File(companyProfileUrl)),
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
                  },
                );
              }),
            ),
            body: loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Center(
                                                  child: Text(
                                                    'Pick Image from Gallery',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Center(
                                                  child: Text(
                                                    'Pick Image from Camera',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child:
                                  companyProfileModel.data.companyLogo.isEmpty
                                      ? const CircleAvatar(
                                          radius: 80,
                                          backgroundImage:
                                              AssetImage('assets/man.jpeg'),
                                        )
                                      : companyProfileUrl.isEmpty
                                          ? CircleAvatar(
                                              radius: 80,
                                              backgroundImage: NetworkImage(
                                                  companyProfileModel
                                                      .data.companyLogo),
                                            )
                                          : CircleAvatar(
                                              radius: 80,
                                              backgroundImage: FileImage(
                                                  File(companyProfileUrl)),
                                            ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "User Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.name,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Employee Email",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.email,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Company Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller:
                                      updateProfileController.companyName,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Company Contact person",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller:
                                      updateProfileController.contactPerson,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "phone",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.phone,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Address",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.address,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "City",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.city,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "State",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.state,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Zip Code",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.zipCode,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6)
                                  ],
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "CreditCard Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller:
                                      updateProfileController.creditCardName,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "CreditCard No",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller:
                                      updateProfileController.creditCardNo,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(16)
                                  ],
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "CreditCard Exp date",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller:
                                      updateProfileController.creditCardExp,
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      String formattedDate = DateFormat('MM/yy')
                                          .format(pickedDate);
                                      setState(() {
                                        updateProfileController
                                                .creditCardExp.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      debugPrint("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Security Code",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller:
                                      updateProfileController.securityCode,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4)
                                  ],
                                  style: const TextStyle(
                                      height: 1.7,
                                      fontSize: 18,
                                      color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
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
                                      borderSide: BorderSide(
                                          color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (updateProfileController
                                        .name.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Oops, userName required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .email.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Oops, Email required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .companyName.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, companyName required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .contactPerson.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, contactPerson required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .phone.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, Phone Number required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                            .phone.text.length !=
                                        10) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, Phone Number should be 10 digits long!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .address.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Oops, Address required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .city.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Oops, City Name required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .state.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, State Name required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .zipCode.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Oops, Zip Code required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                            .zipCode.text.length !=
                                        6) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, Zip Code should be 6 digits long!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .creditCardName.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, CreditCard Name required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .creditCardNo.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, CreditCard Number required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                            .creditCardNo.text.length !=
                                        16) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops,creditCard Number should be 16 digits long!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .creditCardExp.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, CreditCard Exp Date required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                        .securityCode.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops, SecurityCode required!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (updateProfileController
                                            .securityCode.text.length !=
                                        4) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Oops,SecurityCode should be 4 digits long!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      if (companyProfileUrl == '') {
                                        print('prifile pik null');

                                        await updateProfileController
                                            .editProfileDetailsWithoutImage(
                                                context)
                                            .then((value) {
                                          ApiConstant.profileImage = '';
                                          ApiConstant.profileImage =
                                              companyProfileModel
                                                  .data.companyLogo;
                                        });
                                      } else {
                                        await updateProfileController
                                            .updateProfileDetails(context,
                                                companyProfilePic:
                                                    File(companyProfileUrl))
                                            .then((value) {
                                          ApiConstant.profileImage = '';
                                          ApiConstant.profileImage =
                                              companyProfileModel
                                                  .data.companyLogo;
                                        });
                                      }
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
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
  }
}
