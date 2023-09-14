import 'package:eticon_downloader/eticon_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Controller/CompanyController/company_download_invoice_controller.dart';
import '../../../Controller/CompanyController/manage_company_contact_invoice_controller.dart';
import '../../../Models/CompanyModels/company_contact_invoice_model.dart';
import '../../../Models/CompanyModels/download_invoice_model.dart';
import '../../../Network/api_constant.dart';
import '../../../Screens/PDFViewer.dart';
import '../../../utils/Colors.dart';
import '../../PopUps/delete_conformation_popup.dart';
import 'company_add_invoice_for_contact.dart';
import 'company_edit_contact_invoice.dart';

class CompanyManageContactInvoice extends StatefulWidget {
  const CompanyManageContactInvoice({Key? key}) : super(key: key);

  @override
  State<CompanyManageContactInvoice> createState() =>
      _CompanyManageContactInvoiceState();
}

class _CompanyManageContactInvoiceState
    extends State<CompanyManageContactInvoice> {
  ManageCompanyContactInvoice manageCompanyContactInvoice =
      ManageCompanyContactInvoice();
  CompanyGetInvoiceContactModel? companyGetInvoiceContactModel;
  List<ListElement> invoiceList = [];
  bool loading = false;

  CompanyDownloadInvoiceController downloadInvoiceController =
      CompanyDownloadInvoiceController();
  CompanyDownloadInvoiceModel? downloadInvoiceModel;

  @override
  void initState() {
    getContactInvoice(context);
    super.initState();
  }

  void refreshData() {
    setState(() {
      getContactInvoice(context);
    });
  }

  Future downloadInvoice(BuildContext context, String id) async {
    await downloadInvoiceController
        .downloadContactInvoice(context, id)
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


  Future<void> downloadFile(String fileName,String id) async {
    await downloadInvoiceController
        .downloadContactInvoice(context, id)
        .then((value) {
      setState(() async {
        if (value != null) {
          /*downloadInvoiceModel = value;
          print(downloadInvoiceModel!.data.downloadUrl);
          await EticonDownloader.downloadFile(
              url: downloadInvoiceModel!.data.downloadUrl);*/

          final directory = await getApplicationDocumentsDirectory();
          final savedDir = directory.path;
          final taskId = await FlutterDownloader.enqueue(
            url: downloadInvoiceModel!.data.downloadUrl,
            savedDir: savedDir,
            fileName: fileName,
            showNotification: true,
            openFileFromNotification: true,
          );

          FlutterDownloader.registerCallback((id, status, progress) {
            if (status == DownloadTaskStatus.complete) {
              print('Downloaded file saved to: $savedDir/$fileName');
            }
          });
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
        .viewContactInvoice(context, id)
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

  Future getContactInvoice(BuildContext context) async {
    setState(() {
      loading = true;
    });
    //s
    await manageCompanyContactInvoice.getContactInvoice(context).then((value) {
      setState(() {
        if (value != null) {
          companyGetInvoiceContactModel = value;
          invoiceList = companyGetInvoiceContactModel!.data.list;
          loading = false;
          print(loading);
          print(companyGetInvoiceContactModel!.message);
        } else {
          invoiceList.clear();
          loading = false;
          print(loading);
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
          child: Text("Manage Contact Invoice",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ApiConstant.profileImage.isEmpty
                ? const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/man.jpeg'),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(ApiConstant.profileImage),
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
                    // initialize(context, value);
                  },
                  onChanged: (value) {
                    // initialize(context, value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 8),
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
                                builder: (context) =>
                                    AddCompanyInvoiceForContact(
                                      callback: () {
                                        refreshData();
                                      },
                                    )));
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
                                  print(detail.contactId);
                                  await viewInvoice(
                                      context, detail.contactInvoiceId);
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
                                              detail.description,
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
                                                  "For : ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  detail.contactFirstName +
                                                      detail.contactLastName,
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
                                                            builder: (context) =>
                                                                CompanyEditCompanyInvoice(
                                                                  contactId: detail
                                                                      .contactId,
                                                                  description:
                                                                      detail
                                                                          .description,
                                                                  amount: detail
                                                                      .amount,
                                                                  invoiceDate:
                                                                      detail
                                                                          .invoiceDate,
                                                                  signatureName:
                                                                      detail
                                                                          .signatureName,
                                                                  signatureUrl:
                                                                      detail
                                                                          .signature,
                                                                  id: detail
                                                                      .contactInvoiceId,
                                                                  callback: () {
                                                                    refreshData();
                                                                  },
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
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
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
                                                    // downloadInvoice(context, detail.id);
                                                   /* downloadInvoice(
                                                        context,
                                                        detail
                                                            .contactInvoiceId);*/
                                                  //  String fileUrl = 'https://example.com/path/to/your/file.pdf'; // Replace with the actual file URL
                                                    String fileName = 'downloaded_file.pdf'; // Specify the desired file name

                                                    downloadFile(fileName,detail.contactInvoiceId);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: appThemeGreen,
                                                    ),
                                                    height: double.infinity,
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
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
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return ConfirmationPopup(
                                                          title: 'Confirmation',
                                                          message:
                                                              'Are you sure you want to delete?',
                                                          onConfirm: () async {
                                                            await manageCompanyContactInvoice
                                                                .deleteContactInvoice(
                                                                    context:
                                                                        context,
                                                                    id: detail
                                                                        .contactInvoiceId)
                                                                .then(
                                                                    (value) => {
                                                                          if (value)
                                                                            {
                                                                              getContactInvoice(context),
                                                                              Navigator.of(context).pop(),
                                                                            }
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
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
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
