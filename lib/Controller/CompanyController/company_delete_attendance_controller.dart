import 'package:flutter/cupertino.dart';

// class CompanyDeleteAttendanceController {
//   Future deleteEmployee(BuildContext context, String id) async {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return const Center(child: CircularProgressIndicator());
//         });
//     var response =
//         await getData(paramUri: ApiConstant.companyDeleteEmployee + id);
//     debugPrint("deleteEmployee response :- ${response.toString()}");
//
//     if (response["status"] == 'True') {
//       var res = CompanyDeleteEmployeeModel.fromJson(response);
//       deleteEmployeeModel = res;
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(res.message),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } else {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response["message"]),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }
