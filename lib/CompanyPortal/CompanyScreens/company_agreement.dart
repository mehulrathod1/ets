import 'dart:io';

import 'package:etsemployee/utils/Colors.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../Controller/CompanyController/company_subscription_controller.dart';

class CompanyAgreement extends StatefulWidget {
  const CompanyAgreement({Key? key}) : super(key: key);

  @override
  State<CompanyAgreement> createState() => _CompanyAgreementState();
}

class _CompanyAgreementState extends State<CompanyAgreement> {
  CompanySubscriptionController subscriptionController =
      CompanySubscriptionController();
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  String signaturePath = "";

  Future getPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
  }

  void _handleClearButtonPressed() async {
    signatureGlobalKey.currentState!.clear();
    File(signaturePath).delete();
    setState(() {});
  }

  void _handleSaveButtonPressed() async {
    signaturePath = "";
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    var path = Platform.isAndroid
        ? await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS)
        : await getApplicationDocumentsDirectory();
    await Directory('$path/Ets signature').create(recursive: true);
    setState(() {
      File('$path/Ets signature/signature.png')
          .writeAsBytesSync(bytes!.buffer.asInt8List());
      signaturePath = '$path/Ets signature/signature.png';
    });
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getPermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Subscription Agreement",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "This Subscription Services Agreement (the “Agreement”) constitutes a legal, binding agreement between Employee Tracking Solutions (ETS) and the client identified in the order form (“Client”) for certain archiving or other Services (as defined in Section 1.1) and states the terms upon which ETS provides such Services to Client. The “Effective Date” of the Agreement shall be the date upon which Client first executes the order form for Services (“Order Form”). By executing an Order Form, Client agrees to the terms of this Agreement; provided that, to the extent of any conflicting term, the Order Form shall supersede this Agreement solely with respect to the conflicting term.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "1. Services",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "1.1 ETS Services. Subject to Client’s compliance with this Agreement, ETS will provide, and hereby grants Client the limited, non-exclusive, non-sublicensable right to access and use ETS websites and mobile apps as a service product, or other services, initially set forth in the order form executed by Client or purchased pursuant to Section 1.2 (“Services”). Service Descriptions are available at: https://www.employeetrackingsolutions.com and employeetrackingsolutions.net and incorporated by reference herein (“Service Description”). ETS may modify the Services and the Service Descriptions from time to time, provided that such modifications do not materially adversely affect the Services. 1.2 Services Activation. Following execution of the Order Form, ETS shall initiate activation of the Service by providing Client with access to an account within the applicable Service (“Activation Date”). 1.3 Data Retention. ETS will retain Client Data for the Term of the Agreement. Following termination or expiration of this Agreement, ETS will retain the Client Data for a minimum of six (6) months. 1.3 Usage Licenses. A user means any user, device, email address, domain or other usage metric indicated on the Order Form for which ETS archives digital data. If such Services are ordered by Client, ETS grants Client the right to use the Services for the number of users that are using the system set forth in the company portal. The number of usersusing the system is how much money the client gets charged monthly. From time-to-timeETS may review Client’s account within the Services to validate Client’s usage of the Service for compliance with this Agreement. Additionally, If Client’s use of a Services exceeds Client’s payments for such Service, Client may be required to pay an additional fee for the applicable service to ETS.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "2. Fees",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "Payment for standard monthly services rendered hereunder shall be made by the Client at the beginning of the month automatically by credit card or ACH. As the client adds employees during the month their will be an additional charge as the client adds new employees. If the client deletes employees during the month the client will be charged for the employee deleted until the end of the month, they have been deleted in. At the beginning of the following month the account resets and the client will be charged for the number of employees they have enrolled on the system.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "3. Client’s Use of the Services.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "3.1 Client Account. Client shall create an account within the Services. Client is responsible for (a) ensuring that Client’s account registration information is complete and accurate; and (b) the security and confidentiality of Client’s account credentials. Client shall designate at least one authorized user who shall have administrative access to Client’s account, with full access privileges and the authority to use the system under the client’s supervision. under Section 1.2 (“Authorized User”). The Authorized User is responsible for managing all aspects of the Services, including without limitation, adding, or removing employee users or deleting the account and suspending service. The Services may only be used by Client’s authorized employees, agents or contractors in the performance of their duties to Client. Client shall notify ETS immediately of any unauthorized use of any password or account or any other known or suspected breach of security. Client shall not permit ETS competitors to access the Services for any reason. Client is solely responsible for all activity which occurs within Client’s account and for the actions of its employees, contractors or agents, whether or not such person is or was acting within the scope of their employment, engagement or agency relationship. 3.2 Acceptable Use Policy. Client shall comply with ETS Acceptable Use Policy. Client is prohibited from, and shall not copy, modify, adapt, transmit, sell, distribute or otherwise use the Services, in whole or in part, except as expressly permitted in this Agreement. Client is responsible for the data and content archived by, or provided to, ETS via the Services and represents and warrants that such content shall not (a) infringe any third party right, including, without limitation, third party rights in patent, trademark, copyright, or trade secret; or (b) constitute a breach of any other right of a third party, including without limitation, any right under contract or tort theories. Client shall abide by all applicable local, state, national or foreign laws, rules, regulations or treaties in connection with Client’s use of the Services including, without limitation, those related to data privacy, communications, SPAM communications, or the transmission and storage of technical or personal data. 3.3 Client Data. Individual Client Company data will be held private and not shared with anyone. Please see Privacy Policy. Client shall notify ETS of any delivery failures or outages of Client’s systems which may affect the service. 3.4 License to Client Data. “Client Data” means the data of Client which gained from using ETS services. The Clients individual data will never be sold, used or given away. However, An Aggregate of all Companies using the service data may be sold or used by ETS without naming the individual Client or its employees. 3.5 Client Indemnification. Client shall indemnify, defend and hold harmless ETS its officers, directors, employees and agents, from and against all claims, losses, damages, liabilities and expenses (including reasonable attorneys’ fees), arising from Client’s breach of any of Client’s obligations under this Section 3. Client’s obligation for indemnification shall be predicated upon (a) ETS providing Client with prompt written notice upon becoming aware of any such claim; provided that, Client shall not be relieved of its obligation for indemnification as the result of ETS failure to provide such notice unless Client is actually prejudiced in defending such a claim as a result of ETS failure to provide notice; (b) if requested by Client, and at Client’s expense, ETS reasonably cooperating with the defense of such claim; and (c) ETS allowing Client sole and exclusive control over the defense and settlement of any such claim.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "4. Confidentiality.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "4.1 Confidential Information. “Confidential Information” means (a) the non-public business or technical information of either party, including but not limited to information relating to either party’s product plans, customers, designs, costs, prices, finances, marketing plans, business opportunities, personnel, research, development or know-how; (b) any information designated by either party as “confidential” or “proprietary” or which, under the circumstances taken as a whole, would reasonably be deemed to be confidential; (c) the terms of this Agreement; or (d) Client Data. “Confidential Information” will not include information that: (i) is in, or enters, the public domain without breach of this Agreement; (ii) the receiving party lawfully receives from a third party without restriction on disclosure and without breach of a nondisclosure obligation; (iii) the receiving party knew prior to receiving such information from the disclosing party; or (iv) the receiving party develops independently without reference to the Confidential Information. 4.2 Confidentiality Obligations. Each party agrees: (a) that it will not disclose to any third party or use for its own benefit or the benefit of any third party, any Confidential Information disclosed to it by the other party except as expressly permitted in this Agreement; and (b) that it will take reasonable measures to maintain the confidentiality of Confidential Information of the other party in its possession or control. Either party may disclose Confidential Information of the other party: (x) pursuant to the order or requirement of a court, administrative or regulatory agency, or other governmental body, provided that the receiving party, if feasible and/or legally permitted to do so, gives reasonable notice to the disclosing party to contest such order or requirement; or (y) to the parties agents, representatives, subcontractors or service providers who have a need to know such information provided that such party maintain the Confidential Information on a confidential basis. 4.3 Remedies. Each party acknowledges and agrees that a breach of the obligations of this Section 4 by the other party will result in irreparable injury to the disclosing party for which there will be no adequate remedy at law, and the disclosing party shall be entitled to seek equitable relief, including injunction and specific performance, in the event of any breach or threatened breach or intended breach by recipient.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "5. Intellectual Property Rights.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "As between ETS and Client, all server hardware, software and applications required to operate the Services, and other associated technology or documentation, are the sole and exclusive property of ETS. Except as expressly stated herein, nothing in this Agreement shall serve to transfer to Client any intellectual property right in or to the Services, Software, ETS trademarks or other intellectual property. ETS retains all right, title and interest in and to the Services, Software and the associated technology and documentation. As between ETS and Client, Individual Client Data is the sole and exclusive property of Client and, other than the limited license to Client Data granted in Section 3, nothing in this Agreement shall serve to transfer to ETS any intellectual property right in the Client Data.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "6. Term and Termination.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "6.1 Term. The Agreement shall commence of the Effective Date and shall remain in effect for the term specified in the Order Form measured from the Activation Date. This Agreement and all purchased Services will automatically renew as a month-to-month service term. 6.2 Termination for Breach. Either party may terminate this Agreement at any time. ETS reserves the right to suspend Client’s access to the Services in the event of any breach of this Agreement and shall not be liable for any damages resulting from such suspension.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "7. Warranty and Disclaimers.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "7.1 Proper Authority. ETS represents that it has the right and authority to enter into this Agreement, to grant to Client the rights hereunder, and that the performance of its obligations under this Agreement will not breach or be in conflict with any other agreement to which ETS is a party to. 7.2 Compliance with Laws. ETS warrants that it will comply with the laws and regulations applicable to ETS business in the performance of the Services. 7.3 EXCEPT AS SET FORTH IN THIS AGREEMENT, ETS MAKES NO REPRESENTATION OR WARRANTY OF ANY KIND IN CONNECTION WITH THE SERVICES, INCLUDING, WITHOUT LIMITATION, ANY OTHER INFORMATION OR MATERIALS PROVIDED, OR MADE AVAILABLE, BY ETS. ETS INFRINGEMENT. ETS DOES NOT REPRESENT OR WARRANT THAT THE SERVICES BE AVAILABLE OR ERROR FREE. ETS SHALL NOT BE LIABLE FOR DELAYS, INTERRUPTIONS, SERVICE FAILURES OR OTHER PROBLEMS INHERENT IN THE USE OF THE INTERNET, ELECTRONIC COMMUNICATIONS OR OTHER SYSTEMS OUTSIDE THE REASONABLE CONTROL OF ETS. ETS MAKES NO REPRESENTATION OR WARRANTY THAT USE OF THE SERVICES GUARANTEES LEGAL COMPLIANCE UNDER ANY FEDERAL, STATE OR INTERNATIONAL STATUTE, LAW, RULE, REGULATION, OR DIRECTIVE.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "8. Remedies and Limitation of Liability.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "8.1 IN NO EVENT WILL EITHER PARTY BE LIABLE TO THE OTHER, OR TO ANY THIRD PARTY, FOR ANY SPECIAL, INDIRECT, INCIDENTAL, PUNITIVE, EXEMPLARY OR CONSEQUENTIAL DAMAGES (INCLUDING LOSS OF USE, DATA, BUSINESS OR PROFITS), ARISING OUT OF OR IN CONNECTION WITH THE SERVICES, WHETHER BASED ON BREACH OF CONTRACT, BREACH OF WARRANTY, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, REGARDLESS OF WHETHER SUCH DAMAGE WAS FORESEEABLE OR WHETHER THE PARTY HAD BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. SMARSH’S AGGREGATE LIABILITY HEREUNDER FOR ALL DAMAGES ARISING UNDER OR RELATING TO THE PROVISION OF SERVICES, NOTWITHSTANDING THE FORM (E.G., CONTRACT, TORT, OR OTHERWISE) IN WHICH ANY ACTION IS BROUGHT, SHALL BE LIMITED TO THE TOTAL AMOUNT OF REGULAR MONTHLY FEES ACTUALLY RECEIVED BY ETS FOR THE APPLICABLE SERVICES IN THE TWELVE (12) MONTH PERIOD PRECEDING THE MONTH IN WHICH THE INCIDENT CAUSING THE DAMAGES AROSE. THE LIMITATION ON LIABILITY SET FORTH ABOVE IS CUMULATIVE; ALL PAYMENTS MADE FOR ALL CLAIMS AND DAMAGES SHALL BE AGGREGATED, TO DETERMINE IF THE LIMIT HAS BEEN REACHED. THE ABOVE LIMITATIONS OF LIABILITY REFLECT AN ALLOCATION OF RISK BETWEEN THE PARTIES IN VIEW OF THE FAVORABLE FEES BEING CHARGED BY ETS RELATIVE TO THE SERVICES DESCRIBED HEREIN AND ARE MATERIAL TERMS HEREOF.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Text(
                    "9. General Provisions.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Expanded(
                    child: Text(
                      "9.1 U.S. Government End User Provisions. ETS provides the Services to government end users solely in accordance with the following: government technical data and software rights related to the Services include only those rights customarily provided to the public as defined in this Agreement. This customary commercial license is provided in accordance with FAR 12.211 (Technical Data) and FAR 12.212 (Software) and, for Department of Defense transactions, DFAR 252.227-7015 (Technical Data – Commercial Items) and DFAR 227.7202-3 (Rights in Commercial Computer Software or Computer Software Documentation). If a government agency has a need for rights not conveyed under these terms, it must negotiate with ETS to determine if there are acceptable terms for transferring such rights, and a mutually acceptable written addendum specifically conveying such rights must be included in any applicable contract or agreement. 9.2 Force Majeure. No failure or omission by the parties hereto in the performance of any obligation of this Agreement shall be deemed a breach of this Agreement, nor shall it create any liability, provided the party uses reasonable efforts to resume performance hereunder, if the same shall arise from any cause or causes beyond the reasonable control of the parties, including, but not limited to the following, which, for the purpose of this Agreement, shall be regarded as beyond the control of the parties in question: (a) acts of God; (b) acts or omissions of any governmental entity; (c) any rules, regulations or orders issued by any governmental authority or any officer, department, agency or instrumentality thereof; (d) fire, storm, flood, earthquake, accident, war, rebellion, insurrection, riot, strikes and lockouts; or (e) utility or telecommunication failures. 9.3 Governing Law. This Agreement will be governed by and construed in accordance with the laws of the State of Florida, without regard to conflict/choice of law principles. Any legal action or proceeding arising under this Agreement will be brought exclusively in the federal or state courts located in Palm Beach County, in the State of Florida, and the parties hereby irrevocably consent to the personal jurisdiction and venue therein. 9.4 Notices. Any legal notice under this Agreement will be in writing and delivered by personal delivery, express courier, or certified or registered mail, postage prepaid and return receipt requested. Notices will be deemed to be effective upon personal delivery, one (1) day after deposit with express courier, five (5) days after deposit in the mail. Notices will be sent to Client at the address set forth on the Order Form or such other address as Client may specify. Notices will be sent to Employee Tracking Solutions at the following address: 5550 Glades Road 5th Floor, Boca Raton FL, 33431 9.5 No Agency. The parties are independent contractors and will have no power or authority to assume or create any obligation or responsibility on behalf of each other. This Agreement will not be construed to create or imply any partnership, agency, or joint venture. 9.6 Entire Agreement. This Agreement is the complete and exclusive agreement between the parties with respect to the subject matter hereof, and supersedes any prior or contemporaneous agreements, negotiations and communications (both written and oral) regarding such subject matter. 9.7 Severability. If for any reason a court of competent jurisdiction finds any provision or portion of this Agreement to be unenforceable, that provision of the Agreement will be enforced to the maximum extent permissible so as to affect the intent of the parties, and the remainder of this Agreement will continue in full force and effect. 9.8 Waiver. Failure of either party to insist on strict performance of any provision herein shall not be deemed a waiver of any rights or remedies that either party shall have and shall not be deemed a waiver of any subsequent default of the terms and conditions thereof. 9.9 Electronic Signatures and Communications. The parties agree that electronic signatures, whether digital or encrypted, by anClients User are intended to authenticate such signatures and give rise to a valid, enforceable, and fully effective agreement. The parties expressly agree that any terms in Client’s purchase or electronic communications, other than orders placed by Client pursuant to Section 1.2, form no part of this Agreement. 9.10 Modifications. ETS may make modifications to this Agreement by posting the modifications to the weblink this Agreement is located at. Client agrees to the updated version thirty days following posting of the modified terms, or upon execution of an Order Form referencing the updated version number and weblink",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "E-Signature",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Sign in the canvas below and save your signature as an image!",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: colorGray),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SfSignaturePad(
                              key: signatureGlobalKey,
                              backgroundColor: Colors.white,
                              strokeColor: Colors.black,
                              minimumStrokeWidth: 1.0,
                              maximumStrokeWidth: 4.0),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _handleClearButtonPressed();
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: colorred),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Clear Signature",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _handleSaveButtonPressed();
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: appThemeGreen),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Submit Signature",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: GestureDetector(
                          onTap: () async {
                            if (signaturePath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops!, signature missing."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              FocusScope.of(context).unfocus();
                              await subscriptionController.addSubscription(
                                  context,
                                  signature: signaturePath);
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: appThemeGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
