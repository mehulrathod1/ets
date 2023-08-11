import 'package:dropdown_below/dropdown_below.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_add_task_cntroller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  const AddTask({required this.callback, Key? key}) : super(key: key);
  final VoidCallback callback;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  EmployeeAddTaskController addTaskController = EmployeeAddTaskController();
  bool termsandcond = false;
  String selectedTask = "Select Order";
  List<DropdownMenuItem<Object?>> taskListItems = [];
  String? profilePic;

  onChangeDropdownBoxSize(selectedTest) {
    setState(() {
      addTaskController.orderId.text = selectedTest['estimate_id'];
      selectedTask = selectedTest['order_name'];
    });
  }

  Future<void> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pic = prefs.getString('profilePic');
    if (pic != null) {
      setState(() {
        profilePic = pic;
      });
    }
  }

  List<DropdownMenuItem<Object?>> buildTaskSizeListItems(xyz) {
    List<DropdownMenuItem<Object?>> items = [];
    items.clear();
    for (var i in xyz) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['order_name'],
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    getProfilePic();
    Future.delayed(const Duration(microseconds: 0), () {
      addTaskController.taskStatus.text = "0";
      addTaskController.getOrderForEmployeeTask(context).then((value) => {
            if (value != null)
              {
                setState(() {
                  taskListItems = buildTaskSizeListItems(value);
                }),
              }
            else
              {
                setState(() {
                  taskListItems.clear();
                }),
              }
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Add Tasks",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: profilePic!.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(profilePic!),
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
                        DropdownBelow(
                            itemWidth: MediaQuery.of(context).size.width - 30,
                            itemTextstyle: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            boxTextstyle: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            boxWidth: MediaQuery.of(context).size.width,
                            boxHeight: 40,
                            boxDecoration: BoxDecoration(
                              color: colorScreenBg,
                              border: Border.all(color: colorGray, width: 1.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7.0)),
                            ),
                            boxPadding: const EdgeInsets.only(
                                left: 12, top: 6, bottom: 6, right: 10),
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: appThemeGreen,
                            ),
                            hint: Text(
                              selectedTask,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: selectedTask == "Select Order"
                                      ? Colors.black.withOpacity(0.60)
                                      : Colors.black),
                            ),
                            onChanged: onChangeDropdownBoxSize,
                            items: taskListItems),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: termsandcond,
                                  fillColor:
                                      MaterialStateProperty.all(appThemeGreen),
                                  onChanged: (v) {
                                    setState(() {
                                      termsandcond = v!;
                                      if (termsandcond == true) {
                                        addTaskController.taskStatus.text = '1';
                                      } else {
                                        addTaskController.taskStatus.text = '0';
                                      }
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
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter task name',
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
                            style: const TextStyle(
                                height: 1.7, fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter due date',
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
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('MM/dd/yyyy').format(pickedDate);
                                debugPrint(formattedDate);
                                setState(() {
                                  addTaskController.dueDate.text =
                                      formattedDate;
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
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: colorGray),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: addTaskController.taskDescription,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter description',
                                fillColor: colorScreenBg,
                                filled: true,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12, top: 6, bottom: 6),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (selectedTask == "Select Order") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Oops!, Please select task from list."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (addTaskController
                                  .taskName.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Oops!, Task name missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (addTaskController
                                  .dueDate.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Oops!, Task due date missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (addTaskController
                                  .taskDescription.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Oops!, Task description missing."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                await addTaskController
                                    .addTask(context)
                                    .then((value) {
                                  setState(() {
                                    widget.callback();
                                    Navigator.pop(context);
                                  });
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
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
