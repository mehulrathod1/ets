import 'package:etsemployee/Models/CompanyModels/GetCompanyEmployeeModel.dart';
import 'package:etsemployee/Models/CompanyModels/converted_file.dart';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:etsemployee/Network/post_api_client.dart';
import 'package:flutter/material.dart';

class GetCompanyEmployeeController {
  Future getCompanyEmployee(BuildContext context,
      {String? search,
      int? page,
      String? department,
      String? startDate,
      String? endDate}) async {
    var response = await getData(
        paramUri:
            "${ApiConstant.companyAllEmployee}searchName=$search&page=$page&department=$department&startdate=$startDate&enddate=$endDate");
    if (response["status"] == "True" && response["data"] != null) {
      return GetCompanyEmployeeModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future getCompanyEmployeeList(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyInbox);
    if (response["status"] == "True" && response["data"] != null) {
      return response["data"]["List"];
    } else {
      return null;
    }
  }
  CSVDowunloadModel? csvDowunloadModel;
  Future downloadCSVFile(BuildContext context, id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
    await getData(paramUri: ApiConstant.DownloadCSV + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CSVDowunloadModel.fromJson(response);
      csvDowunloadModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message!),
          duration: const Duration(seconds: 2),
        ),
      );
      return CSVDowunloadModel.fromJson(response);
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
  Future downloadExcelFile(BuildContext context,id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
    await getData(paramUri: ApiConstant.DownloadExcel + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CSVDowunloadModel.fromJson(response);
      csvDowunloadModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message!),
          duration: const Duration(seconds: 2),
        ),
      );
      return CSVDowunloadModel.fromJson(response);
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
  Future downloadPDFFile(BuildContext context,id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    var response =
    await getData(paramUri: ApiConstant.DownloadPDF + id);
    if (response["status"] == "True" && response["data"] != null) {
      var res = CSVDowunloadModel.fromJson(response);
      csvDowunloadModel = res;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.message!),
          duration: const Duration(seconds: 2),
        ),
      );
      return CSVDowunloadModel.fromJson(response);
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


}
