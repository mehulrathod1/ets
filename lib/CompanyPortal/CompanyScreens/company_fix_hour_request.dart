import 'package:etsemployee/CompanyPortal/PopUps/request_detail_popup.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class CompanyFixHourRequest extends StatefulWidget {
  const CompanyFixHourRequest({Key? key}) : super(key: key);

  @override
  State<CompanyFixHourRequest> createState() => _CompanyFixHourRequestState();
}

class _CompanyFixHourRequestState extends State<CompanyFixHourRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(width: 1, color: appThemeBlue),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Kate Thomas test",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Date: ",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Dec 27,2022",
                                        style: TextStyle(fontSize: 14, color: colorTextGray),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                width: double.infinity,
                                height: 35,
                                decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          requestDetail(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(color: appThemeBlue, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15))),
                                          height: double.infinity,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.remove_red_eye_sharp,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "View Details",
                                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: appThemeGreen,
                                        ),
                                        height: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                "Accept",
                                                style: TextStyle(fontSize: 14, color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(color: colorred, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15))),
                                        height: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.delete_outline,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(fontSize: 14, color: Colors.white),
                                              ),
                                            )
                                          ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
