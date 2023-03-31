import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/Colors.dart';

class CompanyRequest extends StatefulWidget {
  const CompanyRequest({Key? key}) : super(key: key);

  @override
  State<CompanyRequest> createState() => _CompanyRequestState();
}

class _CompanyRequestState extends State<CompanyRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: appThemeGreen)),
          child: Center(child: Text('No Approvals')),
        ),
      ),
    );
  }
}
