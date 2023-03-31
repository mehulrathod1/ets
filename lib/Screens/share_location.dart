import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../utils/Colors.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({Key? key}) : super(key: key);

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
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
                        EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorGray, width: 1.0),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 510,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appThemeGreen)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 510,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/map.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appThemelightPink),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Stop Sharing",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appThemeGreen),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text("Start Sharing",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
