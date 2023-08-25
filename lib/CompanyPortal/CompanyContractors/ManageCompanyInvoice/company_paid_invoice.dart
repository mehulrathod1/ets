import 'package:eticon_downloader/eticon_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Controller/CompanyController/company_delete_invoice_controller.dart';
import '../../../Controller/CompanyController/company_download_invoice_controller.dart';
import '../../../Controller/CompanyController/company_invoive_controller.dart';
import '../../../Models/CompanyModels/company_invoice_model.dart';
import '../../../Models/CompanyModels/download_invoice_model.dart';
import '../../../Screens/PDFViewer.dart';
import '../../../utils/Colors.dart';
import '../../PopUps/delete_conformation_popup.dart';
import 'company_un_paid_invoice.dart';
import 'edit_company_invoice.dart';

class CompanyPaidInvoice extends StatefulWidget {
  const CompanyPaidInvoice({Key? key}) : super(key: key);

  @override
  State<CompanyPaidInvoice> createState() => _CompanyPaidInvoiceState();
}

class _CompanyPaidInvoiceState extends State<CompanyPaidInvoice> {
  CompanyInvoiceController invoiceController = CompanyInvoiceController();
  late CompanyAllInvoiceModel allInvoiceModel;
  bool loading = false;
  List<ListElement> invoiceList = [];
  CompanyDeleteInvoiceController deleteInvoiceController =
      CompanyDeleteInvoiceController();

  String _platformVersion = 'Unknown';

  CompanyDownloadInvoiceController downloadInvoiceController =
      CompanyDownloadInvoiceController();
  CompanyDownloadInvoiceModel? downloadInvoiceModel;

  @override
  void initState() {
    initPlatformState();
    initialize(context, '');
    super.initState();
  }

  void refreshData() {
    setState(() {
      initialize(context, '');
    });
  }

  Future initialize(BuildContext context, String search) async {
    setState(() {
      loading = true;
    });
    await invoiceController
        .getCompanyPaidInvoice(context, search: search, page: 1)
        .then((value) {
      setState(() {
        if (value != null) {
          allInvoiceModel = value;
          invoiceList = allInvoiceModel.data.list;
          loading = false;
        } else {
          invoiceList.clear();
          loading = false;
        }
      });
    });
  }

  Future downloadInvoice(BuildContext context, String id) async {
    await downloadInvoiceController.downloadInvoice(context, id).then((value) {
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
    await downloadInvoiceController.viewInvoice(context, id).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            loading
                ? Center(child: CircularProgressIndicator())
                : invoiceList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: invoiceList.length,
                        itemBuilder: (context, index) {
                          var data = invoiceList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () async {
                                  await viewInvoice(context, data.id);
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
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.invoiceDescription,
                                              style: TextStyle(
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
                                                  data.paidBy,
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
                                                  data.invoiceFor,
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
                                                  data.amount,
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
                                                            Radius.circular(
                                                                15))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditCompanyInvoice(
                                                                    id: data.id,
                                                                    estimateId:
                                                                        data.estimateId,
                                                                    invoiceFor:
                                                                        data.invoiceFor,
                                                                    invoiceDescription:
                                                                        data.invoiceDescription,
                                                                    amount: data
                                                                        .amount,
                                                                    invoiceDate: data
                                                                        .invoiceDate
                                                                        .toString(),
                                                                    tax: data
                                                                        .tax,
                                                                    dueAmount: data
                                                                        .dueAmount,
                                                                    totalAmount:
                                                                        data.totalAmount,
                                                                    isPaid: data
                                                                        .isPaid,
                                                                    paidBy: data
                                                                        .paidBy,
                                                                    signatureName:
                                                                        data.signatureName,
                                                                    signature: data
                                                                        .signature,
                                                                    callback:
                                                                        refreshData,
                                                                  )));
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
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      downloadInvoice(
                                                          context, data.id);
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
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return ConfirmationPopup(
                                                            title:
                                                                'Confirmation',
                                                            message:
                                                                'Are you sure you want to delete?',
                                                            onConfirm: () {
                                                              deleteInvoiceController
                                                                  .deleteInvoice(
                                                                      context,
                                                                      data.id)
                                                                  .then(
                                                                      (value) {
                                                                initialize(
                                                                    context,
                                                                    '');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                              // Close the dialog
                                                            },
                                                          );
                                                        },
                                                      );
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
                                                            Icons
                                                                .delete_outline,
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
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : const Text(
                        'Oops No Invoice Found!',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
          ],
        ),
      ),
    );
  }
}