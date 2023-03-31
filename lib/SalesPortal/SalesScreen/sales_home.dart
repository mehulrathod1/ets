import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../utils/Colors.dart';

class SalesHome extends StatefulWidget {
  const SalesHome({Key? key}) : super(key: key);

  @override
  State<SalesHome> createState() => _SalesHomeState();
}

class _SalesHomeState extends State<SalesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          color: colorGreenLight,
                          border: Border.all(color: colorGreen, width: 1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset('assets/noun-history.png'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "4",
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold),
                                ),
                                ImageIcon(
                                  AssetImage("assets/department.png"),
                                  size: 60,
                                ),
                              ],
                            ),
                            // Icon(
                            //   Icons.location_on_outlined,
                            //   size: 60,
                            // ),
                            SizedBox(height: 8),
                            Text("Company(s)",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          color: colorPinkLight,
                          border: Border.all(color: colorPink, width: 1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset('assets/noun-history.png'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "44",
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold),
                                ),
                                ImageIcon(
                                  AssetImage("assets/nounGroup.png"),
                                  size: 60,
                                ),
                              ],
                            ),
                            // Icon(
                            //   Icons.location_on_outlined,
                            //   size: 60,
                            // ),
                            SizedBox(height: 8),
                            Text(
                              "Agent(s)",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
