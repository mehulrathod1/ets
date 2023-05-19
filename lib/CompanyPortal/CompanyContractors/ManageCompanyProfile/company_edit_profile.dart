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
  CompanyUpdateProfileController updateProfileController = CompanyUpdateProfileController();
  CompanyProfileController companyProfileController = CompanyProfileController();
  late CompanyProfileModel companyProfileModel;
  TextEditingController expDate = TextEditingController();
  bool loading = false;
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
        updateProfileController.companyName.text = companyProfileModel.data.companyName;
        updateProfileController.contactPerson.text = companyProfileModel.data.contactPerson;
        updateProfileController.phone.text = companyProfileModel.data.phone;
        updateProfileController.address.text = companyProfileModel.data.address;
        updateProfileController.city.text = companyProfileModel.data.city;
        updateProfileController.state.text = companyProfileModel.data.state;
        updateProfileController.zipCode.text = companyProfileModel.data.zip;
        updateProfileController.creditCardName.text = companyProfileModel.data.creditcardName;
        updateProfileController.creditCardNo.text = companyProfileModel.data.creditcardNo;
        updateProfileController.creditCardExp.text = companyProfileModel.data.creditcardExpDate;
        updateProfileController.securityCode.text = companyProfileModel.data.securityCode;
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
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Center(
                child: Text("Edit Details", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
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
                              backgroundImage: NetworkImage(companyProfileModel.data.companyLogo),
                            )
                          : CircleAvatar(
                              radius: 18,
                              backgroundImage: FileImage(File(companyProfileUrl)),
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
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              child: companyProfileModel.data.companyLogo.isEmpty
                                  ? const CircleAvatar(
                                      radius: 80,
                                      backgroundImage: AssetImage('assets/man.jpeg'),
                                    )
                                  : companyProfileUrl.isEmpty
                                      ? CircleAvatar(
                                          radius: 80,
                                          backgroundImage: NetworkImage(companyProfileModel.data.companyLogo),
                                        )
                                      : CircleAvatar(
                                          radius: 80,
                                          backgroundImage: FileImage(File(companyProfileUrl)),
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
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "User Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.name,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Employee Email",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.email,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'crazycoder09@gmail.com',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Company Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.companyName,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'test11',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Company Contact person",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.contactPerson,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'IT',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
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
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Address",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.address,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "City",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.city,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "State",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.state,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
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
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "CreditCard Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.creditCardName,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "CreditCard No",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.creditCardNo,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Creditcard Exp date",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.creditCardExp,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      String formattedDate = DateFormat('MM/yy').format(pickedDate);
                                      setState(() {
                                        updateProfileController.creditCardExp.text = formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      debugPrint("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0, right: 8),
                                child: Text(
                                  "Security Code",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: updateProfileController.securityCode,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Test Edit 1',
                                    fillColor: colorScreenBg,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: colorGray, width: 1.0),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await updateProfileController.updateProfileDetails(context, companyProfilePic: File(companyProfileUrl)).then((value) {
                                      ApiConstant.profileImage = '';
                                      ApiConstant.profileImage = companyProfileModel.data.companyLogo;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
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
