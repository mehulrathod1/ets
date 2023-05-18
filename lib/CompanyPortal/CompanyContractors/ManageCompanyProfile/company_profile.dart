import 'dart:io';
import 'package:etsemployee/Controller/CompanyController/company_profile_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_profile_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'company_change_password.dart';
import 'company_edit_profile.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  CompanyProfileController companyLoginController = CompanyProfileController();
  CompanyProfileModel? companyProfileModel;
  bool loading = false;
  XFile? image;
  bool myImage = true;

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyLoginController.getCompanyProfile(context).then((value) {
      setState(() {
        if (value != null) {
          companyProfileModel = value;
          loading = false;
        } else {
          loading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: colorScreenBg,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: myImage
                          ? companyProfileModel!.data.companyLogo.isEmpty
                              ? const CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage('assets/man.jpeg'),
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(companyProfileModel!.data.companyLogo),
                                )
                          : CircleAvatar(
                              radius: 80,
                              child: Image.file(File(image!.path), fit: BoxFit.fitHeight),
                            ),
                    ),
                  ),
                  Text(
                    companyProfileModel!.data.companyName,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      companyProfileModel!.data.email,
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8, bottom: 8),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: Colors.black), color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Name: ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.username,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Email: ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.email,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Company Name: ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.companyName,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Contact Person: ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  //height: 40,
                                 // color:Colors.red,
                                  width: MediaQuery.of(context).size.width*0.46,
                                  child: FittedBox(
                                    child: Text(
                                      "${companyProfileModel!.data.contactPerson}",
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 18, color: colorTextGray),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Phone : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.phone,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Address : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.address,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "City : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.city,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "State : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.state,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Zip Code : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.zip,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Creditcard No : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.creditcardNo,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Creditcard Exp date: ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.creditcardExpDate,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Security Code : ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyProfileModel!.data.securityCode,
                                  style: TextStyle(fontSize: 18, color: colorTextGray),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyEditProfile()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyChangePassword(profilePicture: companyProfileModel!.data.companyLogo)));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 18),
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
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
