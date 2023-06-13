import 'package:etsemployee/CommonWidget/CommonAppbar.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_get_hour_request_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_get_hour_request_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class ViewHourRequest extends StatefulWidget {
  const ViewHourRequest({Key? key}) : super(key: key);

  @override
  State<ViewHourRequest> createState() => _ViewHourRequestState();
}

class _ViewHourRequestState extends State<ViewHourRequest> {
  EmployeeGetHourRequestController employeeGetHourRequestController = EmployeeGetHourRequestController();
  bool loading = false;
  ScrollController? controller;
  int page = 1;
  int totalPage = 0;
  EmployeeGetHourRequestModel? employeeGetHourRequestModel;
  List<ListElement> requestList = [];

  @override
  void initState() {
    initialize(context, '');
    super.initState();
  }

  @override
  void dispose() {
    controller!.removeListener(scrollListener);
    super.dispose();
  }

  Future initialize(BuildContext context, String search) async {
    setState(() {
      loading = true;
    });
    loading = true;
    await employeeGetHourRequestController
        .getEmployeeRequest(context, search: search, page: page)
        .then((value) {
      setState(() {
        if (value != null) {
          employeeGetHourRequestModel = value;
          requestList = employeeGetHourRequestModel!.data.list;
          loading = false;
          page = page + 1;
          totalPage =
              employeeGetHourRequestModel!.data.paginationInfo.totalPages;
        } else {
          requestList.clear();
          loading = false;
        }
      });
      controller = ScrollController()..addListener(scrollListener);
    });
  }

  Future scrollListener() async {
    if (totalPage < page) {
      return;
    }
    if (controller!.position.extentAfter <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await employeeGetHourRequestController
          .getEmployeeRequest(context, page: page)
          .then((value) {
        if (value != null) {
          setState(() {
            employeeGetHourRequestModel = value;
            requestList.addAll(employeeGetHourRequestModel!.data.list);
            page = page + 1;
            totalPage =
                employeeGetHourRequestModel!.data.paginationInfo.totalPages;
            Navigator.pop(context);
          });
        } else {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: const CommonAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                style: const TextStyle(fontSize: 18, color: Colors.black),
                textInputAction: TextInputAction.search,
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
                onChanged: (value) {
                  print(value);
                },
                onSubmitted: (value) {
                  print('Entered value: $value');
                  initialize(context, value);
                },
              ),
            ),
          ),
          loading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Expanded(
                    child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        var detail = requestList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.employeeName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     const Text(
                                      //       "Request date: ",
                                      //       style: TextStyle(
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //     Text(
                                      //       detail.attendanceDateIn,
                                      //       style: TextStyle(
                                      //           fontSize: 14,
                                      //           color: colorTextGray),
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Attendance In Date: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            detail.attendanceDateIn,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: colorTextGray),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Attendance Out Date: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            detail.attendanceDateOut,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: colorTextGray),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "In Time: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            detail.inTime,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: colorTextGray),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Out Time: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            detail.outTime,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: colorTextGray),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Message:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                              child: Text(
                                            detail.message,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: colorTextGray),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 18.0),
                                //   child: Container(
                                //     width: double.infinity,
                                //     height: 35,
                                //     decoration: BoxDecoration(
                                //         color: colorButtonYellow,
                                //         borderRadius: const BorderRadius.only(
                                //             bottomLeft: Radius.circular(15),
                                //             bottomRight: Radius.circular(15))),
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(left: 8.0),
                                //       child: Center(
                                //         child: Text(
                                //           "View Image",
                                //           style: TextStyle(
                                //               fontSize: 14,
                                //               color: colorTextYellow,
                                //               fontWeight: FontWeight.bold),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
