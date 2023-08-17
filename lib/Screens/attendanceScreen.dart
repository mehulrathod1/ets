// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:etsemployee/Controller/EmployeeController/employee_add_attendance_controller.dart';
import 'package:etsemployee/Popup/attandance_popup.dart';
import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/EmployeeController/employee_check_attendance_controller.dart';
import '../Models/EmployeeModel/employee_check_attendance_model.dart';
import '../Network/api_constant.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({required this.appBar, Key? key}) : super(key: key);
  bool appBar;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreen();
}

class _AttendanceScreen extends State<AttendanceScreen> {
  EmployeeAddAttendanceController controller =
      EmployeeAddAttendanceController();
  bool loading = false;
  String profileImagePath = "";
  String base64ImagePath = "";
  String currentAddress = "";
  Placemark? place;
  TextEditingController addressController = TextEditingController();
  Position? currentPosition;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  static const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  EmployeeCheckAttendanceStatus checkAttendanceStatus =
      EmployeeCheckAttendanceStatus();
  late EmployeeCheckAttendanceModel checkAttendanceModel;

  Future<String> getAttendanceValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.get('attendanceStatus').toString();
    return status;
  }

  Future getStatus(BuildContext context) async {
    // loading = true;
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd');
    String istFormattedTime = format.format(now);
    debugPrint(istFormattedTime);

    checkAttendanceStatus
        .checkAttendanceStatus(context, istFormattedTime)
        .then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String s = prefs.get('attendanceStatus').toString();
      AttendancePopUP(context, s);
    });
  }

  Future pickImage({bool gallery = true}) async {
    try {
      final image = await ImagePicker().pickImage(
          source: gallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      File imageFile = File(image.path);
      Uint8List imageBytes = await imageFile.readAsBytes();
      List<int> compressedBytes =
          await FlutterImageCompress.compressWithList(imageBytes,
              minHeight: 300, // Desired minimum height
              minWidth: 300,
              quality: 100 // Desired minimum width
              );
      setState(() {
        profileImagePath = image.path;
        base64ImagePath = base64.encode(compressedBytes);
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }

    String status = await getAttendanceValue();

    DateTime now = DateTime.now();
    String timeZone = now.timeZoneName;
    print('Time zone: $timeZone');

    DateFormat format = DateFormat('HH:mm:ss');
    String istFormattedTime = format.format(now);
    print('IST Time: $istFormattedTime');

    // String timezone = await FlutterNativeTimezone.getLocalTimezone();
    // print('IST Time: $timezone');

    await controller.addAttendanceHistory(
        context: context,
        address: currentAddress,
        profileImage: base64ImagePath,
        status: status,
        place: place!,
        timeZon: timeZone,
        time: istFormattedTime);
  }

  Future<String> getTimeZone() async {
    String timeZone;
    try {
      timeZone = await FlutterNativeTimezone.getLocalTimezone();
    } on PlatformException {
      timeZone = 'Failed to get the time zone.';
    }
    return timeZone;
  }

  Future<void> getCurrentPosition() async {
    setState(() {
      loading = true;
      currentAddress = "";
      addressController.clear();
      markers.clear();
    });
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        currentPosition = position;
        markers.add(Marker(
            markerId: const MarkerId('Id'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'My Current Location')));
        loading = false;
      });
      await getAddressFromLatLng(currentPosition!);
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await googleMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getCurrentPositionn() async {
    setState(() {
      loading = true;
      currentAddress = "";
      addressController.clear();
      markers.clear();
    });

    // Request location permission
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          currentPosition = position;
          markers.add(Marker(
            markerId: const MarkerId('Id'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'My Current Location'),
          ));
          loading = false;
        });

        await getAddressFromLatLng(currentPosition!);

        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
        );
        final GoogleMapController controller = await googleMapController.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      // Handle denied permission
      // You can show a dialog or a message to the user here
    }
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      place = placemarks[0];
      setState(() {
        currentAddress =
            '${place!.street}, ${place!.subLocality}, ${place!.postalCode}, ${place!.locality}, ${place!.administrativeArea}, ${place!.subAdministrativeArea}, ${place!.country}';
        addressController.text = currentAddress;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      // print('${status}ooooo');
      getStatus(context);
      // getCurrentPositionn();
      getCurrentPosition();
      tz.initializeTimeZones();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: widget.appBar
          ? AppBar(
              elevation: 0,
              backgroundColor: colorScreenBg,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Center(
                child: Text("Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: ApiConstant.profileImage.isEmpty
                      ? const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/man.jpeg'),
                        )
                      : CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(ApiConstant.profileImage),
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
            )
          : null,
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
                        child: profileImagePath.isEmpty
                            ? Image.asset(
                                'assets/man.jpeg',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(profileImagePath),
                                fit: BoxFit.cover,
                              ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (currentAddress.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Oops!, Please wait while we fetching your location."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            await pickImage(gallery: false);
                          }
                        },
                        // {
                        //   await showModalBottomSheet(
                        //       shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.vertical(
                        //           top: Radius.circular(25.0),
                        //         ),
                        //       ),
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return Container(
                        //           height: 100,
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 15, horizontal: 20),
                        //           child: Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceEvenly,
                        //               children: [
                        //                 /*GestureDetector(
                        //             onTap: () async {
                        //               Navigator.pop(context);
                        //               await pickImage(gallery: true);
                        //               await getCurrentPosition();
                        //             },
                        //             child: Container(
                        //               width: double.infinity,
                        //               height: 40,
                        //               decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                        //               child: const Center(
                        //                 child: Text(
                        //                   'Pick Image from Gallery',
                        //                   style: TextStyle(color: Colors.white, fontSize: 18),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),*/
                        //                 GestureDetector(
                        //                   onTap: () async {
                        //                     Navigator.pop(context);
                        //                     await pickImage(gallery: false);
                        //                     await getCurrentPosition();
                        //                   },
                        //                   child: Container(
                        //                     width: double.infinity,
                        //                     height: 40,
                        //                     decoration: BoxDecoration(
                        //                         color: appThemeBlue,
                        //                         borderRadius:
                        //                             BorderRadius.circular(8)),
                        //                     child: const Center(
                        //                       child: Text(
                        //                         'Pick Image from Camera',
                        //                         style: TextStyle(
                        //                             color: Colors.white,
                        //                             fontSize: 18),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ]),
                        //         );
                        //       });
                        // },
                        child: Container(
                          width: double.infinity,
                          height: 35,
                          color: appThemeBlue,
                          child: const Center(
                            child: Text(
                              'Take Photo',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80)),
                      child: ApiConstant.profileImage.isEmpty
                          ? Image.asset(
                              'assets/man.jpeg',
                              fit: BoxFit.cover,
                            )
                          : Image.network(ApiConstant.profileImage)),
                ),

                // const Padding(
                //   padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                //   child: Text(
                //     "Location",
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: SizedBox(
                //     height: 180,
                //     width: double.infinity,
                //     child: loading
                //         ? Container(
                //             height: 180,
                //             width: double.infinity,
                //             alignment: Alignment.center,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(
                //                     color: Colors.black, width: 0.5)),
                //             child: const Center(
                //                 child: CircularProgressIndicator()))
                //         : currentAddress.isEmpty
                //             ? Container(
                //                 height: 180,
                //                 width: double.infinity,
                //                 alignment: Alignment.center,
                //                 decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(8),
                //                     border: Border.all(
                //                         color: Colors.black, width: 0.5)),
                //                 child: const Text(
                //                   "No Location found!",
                //                   style: TextStyle(
                //                       fontSize: 20, color: Colors.black),
                //                 ),
                //               )
                //             : Container(
                //                 height: 180,
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(8),
                //                     border: Border.all(
                //                         color: Colors.black, width: 0.5)),
                //                 child: GoogleMap(
                //                   mapType: MapType.hybrid,
                //                   initialCameraPosition: kGooglePlex,
                //                   myLocationEnabled: true,
                //                   markers: Set<Marker>.of(markers),
                //                   onMapCreated:
                //                       (GoogleMapController controller) {
                //                     googleMapController.complete(controller);
                //                   },
                //                 ),
                //               ),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Address",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextField(
                  enabled: false,
                  style: const TextStyle(height: 1.7, color: Colors.black),
                  maxLines: 1,
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Please wait Searching your location',
                    fillColor: colorTextField,
                    filled: true,
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: InkWell(
                //     onTap: () async {
                //       if (profileImagePath.isEmpty) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content:
                //                 Text("Oops!, Please choose a photo first."),
                //             duration: Duration(seconds: 1),
                //           ),
                //         );
                //       } else if (currentAddress.isEmpty) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content: Text(
                //                 "Oops!, Please wait while we fetching your location."),
                //             duration: Duration(seconds: 1),
                //           ),
                //         );
                //       } else {
                //         String status = await getAttendanceValue();
                //         await controller.addAttendanceHistory(
                //             context: context,
                //             address: currentAddress,
                //             profileImage: base64ImagePath,
                //             status: status,
                //             place: place!);
                //       }
                //     },
                //     child: Container(
                //       width: double.infinity,
                //       height: 40,
                //       decoration: BoxDecoration(
                //           color: appThemeGreen,
                //           borderRadius: BorderRadius.circular(8)),
                //       child: const Center(
                //         child: Text(
                //           'Submit',
                //           style: TextStyle(color: Colors.white, fontSize: 18),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
