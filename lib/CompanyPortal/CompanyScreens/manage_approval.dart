import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Controller/CompanyController/company_accepr_profile_controller.dart';
import '../../Controller/CompanyController/company_approval_controller.dart';
import '../../Controller/CompanyController/compay_reject_profile_request.dart';
import '../../Models/CompanyModels/company_approval_model.dart';
import '../../Network/api_constant.dart';

class ManageApproval extends StatefulWidget {
  ManageApproval({required this.appBar, Key? key}) : super(key: key);
  bool appBar;

  @override
  State<ManageApproval> createState() => _ManageApprovalState();
}

class _ManageApprovalState extends State<ManageApproval> {
  bool loading = false;
  CompanyApprovalController approvalController = CompanyApprovalController();
  late CompanyApprovalModel approvalModel;
  List<ListElement> approvalList = [];

  CompanyAcceptProfileController acceptProfileController =
      CompanyAcceptProfileController();
  CompanyRejectProfileRequest rejectProfileRequest =
      CompanyRejectProfileRequest();

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await approvalController.getApproval(context).then((value) {
      setState(() {
        if (value != null) {
          approvalModel = value;
          approvalList = approvalModel.data.list;
          debugPrint(approvalModel.message);
          loading = false;
        } else {
          approvalList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No data found'),
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
      appBar: widget.appBar
          ? AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Center(
                child: Text("Manage Approval",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: ApiConstant.profileImage.isEmpty
                      ? const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        )
                      : CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(ApiConstant.profileImage),
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
            )
          : null,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: approvalList.length,
                  itemBuilder: (context, index) {
                    var data = approvalList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(data.currentEmployeeImg),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Text(
                                      data.employeeName,
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
                                      data.date,
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
                                      : data.status == 'rejected'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 8, right: 10),
                                              child: Text(
                                                data.status,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: colorred),
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    acceptProfileController
                                                        .acceptProfileRequest(
                                                            context,
                                                            data.id,
                                                            data.employeeId)
                                                        .then((value) {
                                                      initialize(context);
                                                    });
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
                                                    rejectProfileRequest
                                                        .rejectProfileRequest(
                                                            context,
                                                            data.id,
                                                            data.employeeId)
                                                        .then((value) {
                                                      initialize(context);
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0, top: 8),
                                                    child: Text(
                                                      "Cancle",
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
