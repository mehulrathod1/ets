// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:etsemployee/Controller/EmployeeController/employee_delete_note_controller.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_note_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_notes_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_note.dart';
import 'edit_note.dart';

class ManageNote extends StatefulWidget {
  ManageNote({Key? key, this.profilePic}) : super(key: key);
  String? profilePic;

  @override
  State<ManageNote> createState() => _ManageNoteState();
}

class _ManageNoteState extends State<ManageNote> {
  bool loading = false;
  late EmployeeNoteModel noteModel;
  List<ListElement> noteList = [];
  EmployeeDeleteNoteController deleteNoteController =
      EmployeeDeleteNoteController();
  EmployeeNoteController employeeNoteController = EmployeeNoteController();

  @override
  void initState() {
    initialize(context, '');
    super.initState();
  }

  Future initialize(BuildContext context, String search) async {
    setState(() {
      loading = true;
    });
    await employeeNoteController
        .getEmployeeContact(context, search: search, page: 1)
        .then((value) {
      setState(() {
        if (value != null) {
          noteModel = value;
          noteList = noteModel.data.list;
          loading = false;
        } else {
          noteList.clear();
          loading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Manage Notes",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: widget.profilePic!.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(widget.profilePic!),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                textInputAction: TextInputAction.search,
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
                  contentPadding:
                      const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(7)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorGray, width: 1.0),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onSubmitted: (value) {
                  print(loading);
                  initialize(context, value);
                },
                onChanged: (value) {
                  initialize(context, value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: appThemeGreen,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNote()));
                      },
                      child: const Text(
                        'Add New Notes',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )),
            ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : noteList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: noteList.length,
                          itemBuilder: (context, index) {
                            var detail = noteList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(2, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80)),
                                        child: Image.asset(
                                          'assets/man.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              detail.noteName,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              detail.noteDescription,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: colorTextGray),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: appThemeBlue,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15))),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => EditNote(
                                                                id: detail.id,
                                                                noteName: detail
                                                                    .noteName,
                                                                noteDescription:
                                                                    detail
                                                                        .noteDescription,
                                                                noteStatus: detail
                                                                    .noteStatus)));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          "View/Edit",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white),
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
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await deleteNoteController
                                                        .deleteNote(
                                                            context, detail.id)
                                                        .then((value) {
                                                      initialize(context, '');
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: colorred,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15))),
                                                    height: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
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
                          },
                        ),
                      )
                    : const Text(
                        'Oops No Notes Found!',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
          ],
        ),
      ),
    );
  }
}
