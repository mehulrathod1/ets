import 'package:etsemployee/Popup/attandance_popup.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreen();
}

class _AttendanceScreen extends State<AttendanceScreen> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  //
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  //
  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  void initState() {
    print('HOME SCREEN INIT STATE');
    AttendancePopUP(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: CommonAppbar(),
      body: SingleChildScrollView(
        child: Container(
          color: colorScreenBg,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80)),
                          child: Image.asset(
                            'assets/man.jpeg',
                            fit: BoxFit.cover,
                          )),
                      GestureDetector(
                        onTap: () {
                          AttendancePopUP(context);
                        },
                        child: Container(
                            width: double.infinity,
                            height: 35,
                            color: appThemeBlue,
                            child: Center(
                              child: Text(
                                'Click Photo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80)),
                      child: Image.asset(
                        'assets/man.jpeg',
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Location",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80)),
                      child: Image.asset('assets/map.jpeg')
                      // GoogleMap(
                      //   mapType: MapType.hybrid,
                      //   initialCameraPosition: _kGooglePlex,
                      //   onMapCreated: (GoogleMapController controller) {
                      //     _controller.complete(controller);
                      //   },
                      // ),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Address",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  child: TextField(
                    style: TextStyle(height: 1.7, color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Ahmedabad,Gujrat',
                      fillColor: colorTextField,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: appThemeGreen,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
