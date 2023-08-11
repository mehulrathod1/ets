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

  Future viewInvoice(BuildContext context, id) async {
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
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);

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

  Future viewEstimate(BuildContext context, id) async {
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
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      return null;
    }
  }

  Future downloadContactInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.companyDownloadContactInvoice + id);
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

  Future viewContactInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.companyDownloadContactInvoice + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);

      return null;
    }
  }

  Future employeeDownloadContactInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(
        paramUri: ApiConstant.employeeDownloadContactInvoice + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future employeeViewContactInvoice(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response = await getData(
        paramUri: ApiConstant.employeeDownloadContactInvoice + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);

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
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future employeeViewEstimate(BuildContext context, id) async {
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
      //   SnackBar(
      //     content: Text(response["message"]),
      //     duration: const Duration(seconds: 2),
      //   ),
      // );
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
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future employeeDownloadOrder(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeInvoiceOrder + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CompanyDownloadInvoiceModel.fromJson(response);
      downloadInvoiceModel = res;
      Navigator.pop(context);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message),
          duration: const Duration(seconds: 2),
        ),
      );
      return CompanyDownloadInvoiceModel.fromJson(response);
    } else {
      Navigator.pop(context);
      Navigator.of(context).pop();

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

  Future employeeViewOrder(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
        await getData(paramUri: ApiConstant.employeeInvoiceOrder + id);
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
