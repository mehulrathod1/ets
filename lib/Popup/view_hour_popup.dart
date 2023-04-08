import 'package:etsemployee/Models/CompanyModels/company_hour_model.dart';
import 'package:flutter/material.dart';

Future viewHours(BuildContext context, List<HoursList> list) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Hours',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'In',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'out',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Total Hours',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var detail = list[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                detail.hoursListIn,
                                style: const TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                detail.out,
                                style: const TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                detail.totalHours,
                                style: const TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        );
      });
}
