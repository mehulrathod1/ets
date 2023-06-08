import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Controller/CompanyController/company_agency_request_controller.dart';
import '../../Models/CompanyModels/company_agency_request_model.dart';
import '../../Network/api_constant.dart';

class CompanyRequest extends StatefulWidget {
  const CompanyRequest({Key? key}) : super(key: key);

  @override
  State<CompanyRequest> createState() => _CompanyRequestState();
}

class _CompanyRequestState extends State<CompanyRequest> {
  CompanyAgencyRequestController agencyRequestController =
      CompanyAgencyRequestController();
  bool loading = false;
  late CompanyAgencyRequestModel companyAgencyRequestModel;
  List<ListElement> requstList = [];

  @override
  void initState() {
    // TODO: implement initState
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await agencyRequestController.getAgencyRequest(context).then((value) {
      setState(() {
        if (value != null) {
          companyAgencyRequestModel = value;
          requstList = companyAgencyRequestModel.data.list;
          debugPrint(companyAgencyRequestModel.message);
          loading = false;
        } else {
          requstList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Request not found'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: requstList.length,
                  itemBuilder: (context, index) {
                    var data = requstList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(data.agentImg),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Text(
                                      '${data.agentName} Sent Joining Request',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                    ),
                                    child: Text(
                                      data.createAt,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  data.status == 'accepted'
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8, right: 10),
                                          child: Text(
                                            data.status,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: appThemeBlue),
                                          ),
                                        )
                                      : data.status == 'cancel'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 8, right: 10),
                                              child: Text(
                                                'rejected',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: colorred),
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // acceptProfileController
                                                    //     .acceptProfileRequest(
                                                    //         context,
                                                    //         data.id,
                                                    //         data.employeeId)
                                                    //     .then((value) {
                                                    //   initialize(context);
                                                    // });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 8,
                                                            right: 10),
                                                    child: Text(
                                                      "Approve",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: appThemeBlue),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // rejectProfileRequest
                                                    //     .rejectProfileRequest(
                                                    //         context,
                                                    //         data.id,
                                                    //         data.employeeId)
                                                    //     .then((value) {
                                                    //   initialize(context);
                                                    // });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0, top: 8),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: colorred),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
