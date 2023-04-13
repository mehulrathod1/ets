import 'package:etsemployee/CompanyPortal/PopUps/request_detail_popup.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Controller/CompanyController/company_hour_accept_controller.dart';
import '../../Controller/CompanyController/company_hour_reject_controlller.dart';
import '../../Controller/CompanyController/company_hour_request_controller.dart';
import '../../Models/CompanyModels/companay_hour_request.dart';
import '../../Models/CompanyModels/companyAcceptHourModel.dart';
import '../../Models/CompanyModels/company_hour_reject_model.dart';
import '../../utils/Colors.dart';
import '../PopUps/request_detail_popup.dart';

class CompanyFixHourRequest extends StatefulWidget {
  const CompanyFixHourRequest({Key? key}) : super(key: key);

  @override
  State<CompanyFixHourRequest> createState() => _CompanyFixHourRequestState();
}

class _CompanyFixHourRequestState extends State<CompanyFixHourRequest> {
  CompanyFixHourRequestController hourRequestController =
  CompanyFixHourRequestController();
  late CompanyHourRequestModel hourRequestModel;
  List<ListElement> requestList = [];

  CompanyAcceptHourController acceptHourController =
  CompanyAcceptHourController();
  late CompanyHourAcceptModel hourAcceptModel;

  ClassHourRejectController hourRejectController = ClassHourRejectController();
  late CompanyHourRejectModel hourRejectModel;

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    hourRequestController.getHourRequest(context).then((value) {
      setState(() {
        hourRequestModel = value;
        requestList = hourRequestModel.data.list;
        print(hourRequestModel.message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: requestList.length,
                itemBuilder: (context, index) {
                  var data = requestList[index];
                  return Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                  child: Container(
                  child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(width: 1, color: appThemeBlue),
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                  data.employeeName.toString(),
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                  height: 8,
                  ),
                  Row(
                  children: [
                  Text(
                  "Date: ",
                  style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
                  ),
                  Text(
                  data.createAt.toString(),
                  style: TextStyle(
                  fontSize: 14,
                  color: colorTextGray),
                  ),
                  ],
                  ),
                  ],
                  ),
                  ),
                  Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                  color: appThemeBlue,
                  borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
                  child: Row(
                  children: [
                  Expanded(
                  child: GestureDetector(
                  onTap: () {
                  requestDetail(context);
                  },
                  child: Container(
                  decoration: BoxDecoration(
                  color: appThemeBlue,
                  borderRadius:
                  BorderRadius.only(
                  bottomLeft:
                  Radius.circular(
                  15))),
                  height: double.infinity,
                  child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                  Icon(
                  Icons.remove_red_eye_sharp,
                  color: Colors.white,
                  size: 20,
                  ),
                  Padding(
                  padding:
                  const EdgeInsets.only(
                  left: 8.0),
                  child: Text(
                  "View Details",
                  style: TextStyle(
                  fontSize: 14,
                  color: Colors.white),
                  ),
                  )
                  ],
                  ),
                  ),
                  ),
                  ),
                  Expanded(
                  child: GestureDetector(
                  onTap: () {
                  acceptHourController
                      .acceptHourRequest(
                  context, data.id)
                      .then((value) {
                  print(value.data);
                  });
                  },
                  child: Container(
                  decoration: BoxDecoration(
                  color: appThemeGreen,
                  ),
                  height: double.infinity,
                  child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                  Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 20,
                  ),
                  Padding(
                  padding:
                  const EdgeInsets.only(
                  left: 8.0),
                  child: Text(
                  "Accept",
                  style: TextStyle(
                  fontSize: 14,
                  color: Colors.white),
                  ),
                  )
                  ],
                  ),
                  ),
                  ),
                  ),
                  Expanded(
                  child: GestureDetector(
                  onTap: () {
                  hourRejectController
                      .rejectHourRequest(context,
                  data.id.toString())
                      .then((value) {
                  print(value.message);
                  });
                  },
                  child: Container(
                  decoration: BoxDecoration(
                  color: colorred,
                  borderRadius:
                  BorderRadius.only(
                  bottomRight:
                  Radius.circular(
                  15))),
                  height: double.infinity,
                  child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                  Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 20,
                  ),
                  Padding(
                  padding:
                  const EdgeInsets.only(
                  left: 8.0),
                  child: Text(
                  "Reject",
                  style: TextStyle(
                  fontSize: 14,
                  color: Colors.white),
                  ),
                  )
                  ],
                  ),
                  ),
                  ),
                  ),
                  ],
                  )),
                  ),

                  ],
                  ),
                  ),)


                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
