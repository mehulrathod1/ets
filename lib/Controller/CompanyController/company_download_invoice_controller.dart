import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CompanyModels/download_invoice_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyDownloadInvoiceController {
  CompanyDownloadInvoiceModel? downloadInvoiceModel;
  // Future downloadInvoice(BuildContext context, String id) async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(child: CircularProgressIndicator());
  //       });
  //   var response =
  //       await getData(paramUri: ApiConstant.companyDownloadInvoice + id);
  //   debugPrint("deleteContact response :- ${response.toString()}");
  //   if (response["status"] == 'True') {
  //     var res = CompanyDownloadInvoiceModel.fromJson(response);
  //     downloadInvoiceModel = res;
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(res.message),
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   } else {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(response["message"]),
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }

  Future downloadInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.companyDownloadInvoice + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future downloadEstimate(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.companyDownloadEstimate + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future employeeDownloadEstimate(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeEstimateDownload + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future employeeDownloadInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeInvoiceDownload + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future employeeViewInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeInvoiceDownload + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(res.message),
      //     duration: const Duration(seconds: 2),
      //   ),
      // );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //       //   SnackBar(
      //       //     content: Text(response["message"]),
      //       //     duration: const Duration(seconds: 2),
      //       //   ),
      //       // );
      return null;
    }
  }
}
