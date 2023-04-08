import 'package:etsemployee/Controller/EmployeeController/employee_task_detail_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_task_detail_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  bool termsandcond = false;
  bool loading = false;
  EmployeeTaskDetailController taskDetailController = EmployeeTaskDetailController();
  late EmployeeTaskDetailModel taskDetailModel;
  List<ListElement> taskData = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await taskDetailController.getTaskDetail(context).then((value) {
      setState(() {
        taskDetailModel = value;
        taskData = taskDetailModel.data.list;
        loading = false;
        debugPrint(taskDetailModel.message);
        debugPrint(taskData[0].taskName);
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
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Edit Tasks", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
            ),
          ),
        ],
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: colorScreenBg,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Task For",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
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
                                        Icons.keyboard_arrow_down_outlined,
                                        color: appThemeGreen,
                                      ),
                                    ),
                                    hintText: 'Test Estimate Section',
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: termsandcond,
                                        fillColor: MaterialStateProperty.all(appThemeGreen),
                                        onChanged: (v) {
                                          setState(() {
                                            termsandcond = v!;
                                          });
                                        }),
                                    const Text(
                                      'Mark As Complete',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Task Name",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: taskData[0].taskName,
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
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Due Date",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: '12/31/1996',
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
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                                child: Text(
                                  "Task Description",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(border: Border.all(width: 1, color: colorGray), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextField(
                                    style: const TextStyle(fontSize: 18, color: Colors.black),
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter description',
                                      fillColor: colorScreenBg,
                                      filled: true,
                                      isDense: true,
                                      contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
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
                                  child: const Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
