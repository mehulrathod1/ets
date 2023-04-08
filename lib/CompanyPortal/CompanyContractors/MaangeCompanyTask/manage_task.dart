import 'package:etsemployee/Controller/CompanyController/company_delete_task_controller.dart';
import 'package:etsemployee/Controller/CompanyController/get_company_task_controller.dart';
import 'package:etsemployee/Models/CompanyModels/get_company_task_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_company_task.dart';
import 'edit_company_task.dart';

class ManageCompanyTask extends StatefulWidget {
  const ManageCompanyTask({Key? key}) : super(key: key);

  @override
  State<ManageCompanyTask> createState() => _ManageCompanyTaskState();
}

class _ManageCompanyTaskState extends State<ManageCompanyTask> {
  bool loading = false;
  GetCompanyTaskController getCompanyTaskController = GetCompanyTaskController();
  CompanyDeleteTaskController deleteTaskController = CompanyDeleteTaskController();
  late CompanyTaskModel companyTaskModel;
  List<ListElement> taskList = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await getCompanyTaskController.getAllCompanyTaks(context).then((value) {
      setState(() {
        companyTaskModel = value;
        taskList = companyTaskModel.data.list;
        loading = false;
        debugPrint(companyTaskModel.message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Manage Tasks", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
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
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCompanyTask()));
                      },
                      child: const Text(
                        'Add New Task',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        var detail = taskList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
                                    child: Image.asset(
                                      'assets/man.jpeg',
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.taskName,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        detail.taskDescription,
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditCompanyTask()));
                                            },
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
                                        const SizedBox(
                                          width: 1,
                                          height: 35,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              deleteTaskController.deleteTask(context, detail.id).then((value) {
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
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
