// ignore_for_file: must_be_immutable

import 'package:eticon_downloader/eticon_downloader.dart';
import 'package:etsemployee/Controller/EmployeeController/employee_invoice_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_invoice_model.dart';
import 'package:etsemployee/Screens/Contractors/ManageInvoice/add_new_invoice.dart';
import 'package:etsemployee/Screens/Contractors/ManageInvoice/edit_invoice.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Controller/CompanyController/company_download_invoice_controller.dart';
import '../../../Models/CompanyModels/download_invoice_model.dart';
import '../../PDFViewer.dart';

class ManageInvoice extends StatefulWidget {
  ManageInvoice({Key? key, this.profilePic}) : super(key: key);
  String? profilePic;

  @override
  State<ManageInvoice> createState() => _ManageInvoiceState();
}

class _ManageInvoiceState extends State<ManageInvoice> {
  bool loading = false;
  late EmployeeInvoiceModel invoiceModel;
  List<ListElement> invoiceList = [];
  EmployeeInvoiceController employeeInvoiceController =
      EmployeeInvoiceController();

  CompanyDownloadInvoiceController downloadInvoiceController =
      CompanyDownloadInvoiceController();
  CompanyDownloadInvoiceModel? downloadInvoiceModel;

  String _platformVersion = 'Unknown';

  @override
  void initState() {
    initPlatformState();
    initialize(context, '');
    super.initState();
  }

  Future initialize(BuildContext context, String search) async {
    setState(() {
      loading = true;
    });
    //s
    await employeeInvoiceController
        .getEmployeeInvoice(context, search: search, page: 1)
        .then((value) {
      setState(() {
        if (value != null) {
          invoiceModel = value;
          invoiceList = invoiceModel.data.list;
          loading = false;
          print(loading);
        } else {
          invoiceList.clear();
          loading = false;
        }
      });
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await EticonDownloader.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future downloadInvoice(BuildContext context, String id) async {
    await downloadInvoiceController
        .employeeDownloadInvoice(context, id)
        .then((value) {
      setState(() async {
        if (value != null) {
          downloadInvoiceModel = value;
          print(downloadInvoiceModel!.data.downloadUrl);
          await EticonDownloader.downloadFile(
              url: downloadInvoiceModel!.data.downloadUrl);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(downloadInvoiceModel!.message),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  Future viewInvoice(BuildContext context, String id) async {
    await downloadInvoiceController
        .employeeViewInvoice(context, id)
        .then((value) {
      setState(() async {
        if (value != null) {
          downloadInvoiceModel = value;
          print(downloadInvoiceModel!.data.downloadUrl);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PdfViewerPage(pdfUrl: downloadInvoiceModel!.data.downloadUrl),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(downloadInvoiceModel!.message),
              duration: const Duration(seconds: 2),
            ),
          );
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
          child: Text("Manage Invoice",
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
      body: SingleChildScrollView(
        child: Padding(
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
                                builder: (context) => const AddNewInvoice()));
                      },
                      child: const Text(
                        'Add New Invoice',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : invoiceList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: invoiceList.length,
                          itemBuilder: (context, index) {
                            var detail = invoiceList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: GestureDetector(
                                onTap: () async {
                                  await viewInvoice(context, detail.id);
                                },
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
                                        height: 180,
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
                                              detail.invoiceDescription,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Paid By: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  detail.paidBy,
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
                                                  "For: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  detail.invoiceFor,
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
                                                  "Amount: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  detail.amount,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: colorTextGray),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 35,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditInvoice(
                                                                      id: detail
                                                                          .id,
                                                                      estimateId:
                                                                          detail
                                                                              .estimateId,
                                                                      invoiceFor:
                                                                          detail
                                                                              .invoiceFor,
                                                                      invoiceDescription:
                                                                          detail
                                                                              .invoiceDescription,
                                                                      amount: detail
                                                                          .amount,
                                                                      invoiceDate:
                                                                          detail
                                                                              .invoiceDate,
                                                                      tax: detail
                                                                          .tax,
                                                                      dueAmount:
                                                                          detail
                                                                              .dueAmount,
                                                                      totalAmount:
                                                                          detail
                                                                              .totalAmount,
                                                                      isPaid: detail
                                                                          .isPaid,
                                                                      paidBy: detail
                                                                          .paidBy,
                                                                      signatureName:
                                                                          detail
                                                                              .signatureName,
                                                                      signature:
                                                                          detail
                                                                              .signature,
                                                                    )));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: appThemeBlue,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15))),
                                                    height: double.infinity,
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
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
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
                                                  onTap: () {
                                                    downloadInvoice(
                                                        context, detail.id);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: appThemeGreen,
                                                    ),
                                                    height: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Icon(
                                                          Icons.download,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            "Download",
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
                                                    await employeeInvoiceController
                                                        .deleteEmployeeInvoice(
                                                            context: context,
                                                            id: detail.id)
                                                        .then((value) => {
                                                              if (value)
                                                                {
                                                                  initialize(
                                                                      context,
                                                                      ''),
                                                                }
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
                        )
                      : const Text(
                          'Oops No Invoice Found!',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
