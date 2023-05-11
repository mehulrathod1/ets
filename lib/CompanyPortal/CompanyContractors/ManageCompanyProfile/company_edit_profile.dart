import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../Controller/CompanyController/company_edit_profile_controller.dart';
import '../../../Controller/CompanyController/company_profile_controller.dart';
import '../../../Models/CompanyModels/company_profile_model.dart';
import '../../../utils/Colors.dart';

class CompanyEditProfile extends StatefulWidget {
  const CompanyEditProfile({Key? key}) : super(key: key);

  @override
  State<CompanyEditProfile> createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  TextEditingController expDate = TextEditingController();

  CompanyProfileController companyProfileController =
      CompanyProfileController();
  late CompanyProfileModel companyProfileModel;
  bool loading = false;
  XFile? image = null;
  String con = "";
  CompanyUpdateProfileController updateProfileController =
      CompanyUpdateProfileController();

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
  void initState() {
    // TODO: implement initState

    initialize(context);

    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await companyProfileController.getCompanyProfile(context).then((value) {
      setState(() {
        companyProfileModel = value;
        debugPrint(companyProfileModel.data.companyName);
        updateProfileController.name.text = companyProfileModel.data.username;
        updateProfileController.companyName.text =
            companyProfileModel.data.companyName;
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
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Center(
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
                : CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        NetworkImage(companyProfileModel.data.companyLogo),
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
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            child: companyProfileModel.data.companyLogo.isEmpty
                                ? const CircleAvatar(
                                    radius: 80,
                                    backgroundImage:
                                        AssetImage('assets/man.jpeg'),
                                  )
                                : CircleAvatar(
                                    radius: 80,
                                    backgroundImage: NetworkImage(
                                        companyProfileModel.data.companyLogo),
                                  )),
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
                                hintText: 'Test Edit 1',
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
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 6.0, right: 8),
                            child: Text(
                              "Employee Email",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              controller: updateProfileController.email,
                              style: TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'crazycoder09@gmail.com',
                                fillColor: colorScreenBg,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
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
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 6.0, right: 8),
                            child: Text(
                              "Company Name",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              controller: updateProfileController.companyName,
                              style: TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'test11',
                                fillColor: colorScreenBg,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
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
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 6.0, right: 8),
                            child: Text(
                              "Company Contact person",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              controller: updateProfileController.contactPerson,
                              style: TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'IT',
                                fillColor: colorScreenBg,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
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
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Test Edit 1',
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
                                hintText: 'Test Edit 1',
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
                                hintText: 'Test Edit 1',
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
                                hintText: 'Test Edit 1',
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
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Test Edit 1',
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
                                hintText: 'Test Edit 1',
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
                              controller: updateProfileController.creditCardNo,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Test Edit 1',
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
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 6.0, right: 8),
                            child: Text(
                              "Creditcard Exp date",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: updateProfileController.creditCardExp,
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Test Edit 1',
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
                                    updateProfileController.creditCardExp.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
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
                              controller: updateProfileController.securityCode,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  height: 1.7,
                                  fontSize: 18,
                                  color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Test Edit 1',
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
                            padding: const EdgeInsets.only(top: 18.0),
                            child: GestureDetector(
                              onTap: () async {
                                await updateProfileController
                                    .updateProfileDetails(context);
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: appThemeGreen,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
