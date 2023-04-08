import 'package:etsemployee/Controller/SalesController/sales_agent_controller.dart';
import 'package:etsemployee/Controller/SalesController/sales_delete_agent_controller.dart';
import 'package:etsemployee/Models/SalesModel/sales_agent_model.dart';
import 'package:etsemployee/Models/SalesModel/sales_delete_agent_model.dart';
import 'package:etsemployee/SalesPortal/ManageAgent/view_agent_company_list.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'add_sales_agent.dart';
import 'edit_sale_agent.dart';

class ManageAgent extends StatefulWidget {
  const ManageAgent({Key? key}) : super(key: key);

  @override
  State<ManageAgent> createState() => _ManageAgentState();
}

class _ManageAgentState extends State<ManageAgent> {
  bool loading = false;
  SalesAgentController agentController = SalesAgentController();
  late SalesAgentModel agentModel;
  List<ListElement> agentList = [];
  SalesAgentDeleteController deleteController = SalesAgentDeleteController();
  late SalesDeleteAgentModel deleteAgentModel;

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await agentController.getAgent(context).then((value) {
      setState(() {
        agentModel = value;
        agentList = agentModel.data.list;
        loading = false;
        debugPrint(value.message);
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
              child: SizedBox(
                height: 40,
                child: TextField(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  maxLines: 1,
                  decoration: InputDecoration(
                    suffixIcon: Align(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: Icon(
                        Icons.search,
                        color: appThemeGreen,
                      ),
                    ),
                    hintText: 'Search',
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '01/19/2023',
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
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Export To Excel',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSalesAgent()));
                      },
                      child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Text(
                              'Add Existing Agent',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Add Agent',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(color: colorred, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: agentList.length,
                      itemBuilder: (context, index) {
                        var data = agentList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                                          data.name,
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Email: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data.email,
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Phone: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data.phone,
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Join Date:: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data.joinDate.toString(),
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Total No Company:: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data.totalNoCompany.toString(),
                                              style: TextStyle(fontSize: 14, color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              "Active: ",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            Icon(Icons.close, color: Colors.red)
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
                                      decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditSalesAgent()));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15))),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Text(
                                                        "Edit",
                                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAgentCompanyList()));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(color: appThemeGreen),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Text(
                                                        "View Company List",
                                                        style: TextStyle(fontSize: 14, color: Colors.white),
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
                                                deleteController.deleteAgent(context, data.id).then((value) {
                                                  deleteAgentModel = value;
                                                  initialize(context);
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(color: colorred, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15))),
                                                height: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
