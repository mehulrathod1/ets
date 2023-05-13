import 'package:etsemployee/Controller/CompanyController/company_profile_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_profile_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  XFile? image = null;
  bool myImage = true;

  Future _imgFromGallery() async {
    myImage = false;
    var image2 = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    print(image2!.path);
    setState(() {
      image = image2;
    });
  }

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyLoginController.getCompanyProfile(context).then((value) {
      setState(() {
        if (value != null) {
          companyProfileModel = value;
          debugPrint(companyProfileModel?.data.companyName);
          urlToFile(companyProfileModel!.data.companyLogo);
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
            // appBar: AppBar(
            //   elevation: 0,
            //   backgroundColor: colorScreenBg,
            //   systemOverlayStyle:
            //       SystemUiOverlayStyle(statusBarColor: Colors.blue),
            //   title: Center(
            //     child: Text("Profile",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(color: Colors.black)),
            //   ),
            //   actions: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.only(right: 16.0),
            //       child: companyProfileModel!.data.companyLogo.isEmpty
            //           ? const CircleAvatar(
            //               radius: 18,
            //               backgroundImage: AssetImage('assets/man.jpeg'),
            //             )
            //           : CircleAvatar(
            //               radius: 18,
            //               backgroundImage: NetworkImage(
            //                   companyProfileModel!.data.companyLogo),
            //             ),
            //     ),
            //   ],
            //   leading: Builder(builder: (context) {
            //     return GestureDetector(
            //       child: Icon(
            //         Icons.arrow_back,
            //         color: Colors.black,
            //       ),
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //     );
            //   }),
            // ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: myImage
                                ? companyProfileModel!.data.companyLogo.isEmpty
                                    ? const CircleAvatar(
                                        radius: 80,
                                        backgroundImage:
                                            AssetImage('assets/man.jpeg'),
                                      )
                                    : CircleAvatar(
                                        radius: 80,
                                        backgroundImage: NetworkImage(
                                            companyProfileModel!
                                                .data.companyLogo),
                                      )
                                : CircleAvatar(
                                    radius: 80,
                                    child: Image.file(File(image!.path),
                                        fit: BoxFit.fitHeight),
                                  )),
                      ),
                    ),
                    Text(
                      companyProfileModel!.data.companyName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        companyProfileModel!.data.email,
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
                                    companyProfileModel!.data.username,
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
                                    companyProfileModel!.data.email,
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
                                    companyProfileModel!.data.companyName,
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
                                    companyProfileModel!.data.contactPerson,
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
                                    companyProfileModel!.data.phone,
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
                                    companyProfileModel!.data.address,
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
                                    companyProfileModel!.data.city,
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
                                    companyProfileModel!.data.state,
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
                                    companyProfileModel!.data.zip,
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
                                    companyProfileModel!.data.creditcardNo,
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
                                    companyProfileModel!.data.creditcardExpDate,
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
                                    companyProfileModel!.data.securityCode,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyChangePassword(
                                      profilePicture: companyProfileModel!
                                          .data.companyLogo)));
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
