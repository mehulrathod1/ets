import 'package:etsemployee/Controller/EmployeeController/employee_add_task_cntroller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool termsandcond = false;
  var taskStatus = '0';
  EmployeeAddTaskController addTaskController = EmployeeAddTaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Add Tasks", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
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
                            controller: addTaskController.orderId,
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
                                      if (termsandcond == true) {
                                        addTaskController.taskStatus.text = '1';
                                      } else {
                                        addTaskController.taskStatus.text = '0';
                                      }
                                      debugPrint(addTaskController.taskStatus.text);
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
                            controller: addTaskController.taskName,
                            style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter task name',
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
                            controller: addTaskController.dueDate,
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
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                debugPrint(pickedDate as String?);
                                String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                                debugPrint(formattedDate);
                                setState(() {
                                  addTaskController.dueDate.text = formattedDate;
                                });
                              } else {
                                debugPrint("Date is not selected");
                              }
                            },
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
                              controller: addTaskController.taskDescription,
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
                          child: GestureDetector(
                            onTap: () {
                              addTaskController.addTask(context);
                            },
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
