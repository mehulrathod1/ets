import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../utils/Colors.dart';

// Future callForAttendance(BuildContext context) async {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           titlePadding: EdgeInsets.zero,
//           title: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Center(
//                           child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Call For Attendance',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       )),
//                       Icon(
//                         Icons.close,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0, bottom: 20),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Container(
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                     color: appThemeBlue,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: Center(
//                                   child: Text(
//                                     'View Details',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 18),
//                                   ),
//                                 )),
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Container(
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                     color: appThemeGreen,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: Center(
//                                   child: Text(
//                                     'Sent',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 18),
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }
