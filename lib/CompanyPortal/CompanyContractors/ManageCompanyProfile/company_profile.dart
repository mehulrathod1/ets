import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Controller/CompanyController/company_profile_controller.dart';
import '../../../Models/CompanyModels/company_profile_model.dart';
import '../../../utils/Colors.dart';
import 'company_edit_profile.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  CompanyProfileController companyLoginController = CompanyProfileController();
  late CompanyProfileModel companyProfileModel;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyLoginController.getCompanyProfile(context).then((value) {
      setState(() {
        companyProfileModel = value;
        debugPrint(companyProfileModel.data.companyName);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
          child: Text("Profile",
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage('assets/man.jpeg'),
                          ))),
                    ),
                    Text(
                      companyProfileModel.data.companyName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        companyProfileModel.data.email,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 8, right: 8, bottom: 8),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: Colors.black),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.username,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.email,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Company Name: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.companyName,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Contact Person: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.contactPerson,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Phone : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.phone,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Address : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.address,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "City : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.city,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "State : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.state,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Zip Code : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.zip,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Creditcard No : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.creditcardNo,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Creditcard Exp date: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.creditcardExpDate,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Security Code : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyProfileModel.data.securityCode,
                                    style: TextStyle(
                                        fontSize: 18, color: colorTextGray),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyEditProfile()));
                        },
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeGreen,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => ResetPassword()));
                        },
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: appThemeBlue,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 18),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ProfileChangeRequest()));
                        },
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Delete Account',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
