import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddNewInvoice extends StatefulWidget {
  const AddNewInvoice({Key? key}) : super(key: key);

  @override
  State<AddNewInvoice> createState() => _AddNewInvoiceState();
}

class _AddNewInvoiceState extends State<AddNewInvoice> {
  bool termsandcond = false;
  TextEditingController invoiceDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Add Invoice", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
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
        child: Container(
          color: colorScreenBg,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Invoice For",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: Align(
                              widthFactor: 1,
                              heightFactor: 1,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: appThemeGreen,
                              ),
                            ),
                            hintText: 'Test Estimate Section',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Estimate Description",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Testing the estimate section description',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Estimate Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '500000',
                            fillColor: colorLightGray,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Changes Order Description",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Testing the estimate section description',
                            fillColor: colorLightGray,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Change Order Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '5000',
                            fillColor: colorLightGray,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Total Amount (Estimate and changes in orders)",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '50000',
                            fillColor: colorLightGray,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Paid Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '50000',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Tax",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '50',
                            fillColor: colorLightGray,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Markup",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '50',
                            fillColor: colorLightGray,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Cost Plus",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '5',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                        child: Text(
                          "Invoice Date",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: invoiceDate,
                          style: const TextStyle(height: 1.7, fontSize: 18, color: Colors.black),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '12/31/1996',
                            fillColor: colorScreenBg,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorGray, width: 1.0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                              setState(() {
                                invoiceDate.text = formattedDate; //set output date to TextField value.
                              });
                            } else {
                              debugPrint("Date is not selected");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            Checkbox(
                                value: termsandcond,
                                fillColor: MaterialStateProperty.all(appThemeGreen),
                                onChanged: (v) {
                                  setState(() {
                                    termsandcond = v!;
                                  });
                                }),
                            const Text(
                              'Is Paid',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
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
                        decoration: BoxDecoration(border: Border.all(width: 1, color: colorGray), borderRadius: const BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextField(
                            style: const TextStyle(fontSize: 18, color: Colors.black),
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'E-Signature',
                              fillColor: colorScreenBg,
                              filled: true,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0, right: 8),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: colorred),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0, right: 8),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: appThemeGreen),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Submit Signature", style: TextStyle(fontSize: 14, color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
