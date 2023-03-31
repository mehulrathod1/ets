import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../utils/Colors.dart';

Future requestDetail(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Request Detail',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                      Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Attendance In Date: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Dec 27,2022",
                          style: TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Attendance In Date: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "01/11/2023",
                          style: TextStyle(fontSize: 14, color: colorTextGray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Total Hours: ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 14, color: colorTextGray),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Break Hours: ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 14, color: colorTextGray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Message",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: Expanded(
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem",
                        style: TextStyle(fontSize: 14, color: colorTextGray),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
