import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import '../../Controller/CompanyController/company_approval_controller.dart';
import '../../Models/CompanyModels/company_approval_model.dart';

class ManageApproval extends StatefulWidget {
  const ManageApproval({Key? key}) : super(key: key);

  @override
  State<ManageApproval> createState() => _ManageApprovalState();
}

class _ManageApprovalState extends State<ManageApproval> {
  bool loading = false;
  CompanyApprovalController approvalController = CompanyApprovalController();
  late CompanyApprovalModel approvalModel;
  List<ListElement> approvalList = [];

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
                                backgroundImage: NetworkImage(data.currentEmployeeImg),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                                    child: Text(
                                      data.employeeName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                    ),
                                    child: Text(
                                      data.date,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                                    child: Text(
                                      "Approved",
                                      style: TextStyle(fontSize: 12, color: appThemeBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: const DecoratedBox(
                                decoration: const BoxDecoration(color: Colors.black),
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
