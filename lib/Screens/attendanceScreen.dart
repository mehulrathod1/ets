// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:etsemployee/Controller/EmployeeController/employee_add_attendance_controller.dart';
import 'package:etsemployee/Popup/attandance_popup.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreen();
}

class _AttendanceScreen extends State<AttendanceScreen> {
  EmployeeAddAttendanceController controller = EmployeeAddAttendanceController();
  bool loading = false;
  String profileImagePath = "";
  String base64ImagePath = "";
  String currentAddress = "";
  Placemark? place;
  TextEditingController addressController = TextEditingController();
  Position? currentPosition;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
  static const CameraPosition kGooglePlex = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Future<String> getAttendanceValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.get('attendanceStatus').toString();
    return status;
  }

  Future pickImage({bool gallery = true}) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      File imageFile = File(image.path);
      Uint8List imageBytes = await imageFile.readAsBytes();
      setState(() {
        profileImagePath = image.path;
        base64ImagePath = base64.encode(imageBytes);
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      setState(() {
        currentPosition = position;
        markers.add(Marker(markerId: const MarkerId('Id'), position: LatLng(position.latitude, position.longitude), infoWindow: const InfoWindow(title: 'My Current Location')));
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

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude).then((List<Placemark> placemarks) {
      place = placemarks[0];
      setState(() {
        currentAddress = '${place!.street}, ${place!.subLocality}, ${place!.postalCode}, ${place!.locality}, ${place!.administrativeArea}, ${place!.subAdministrativeArea}, ${place!.country}';
        addressController.text = currentAddress;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      AttendancePopUP(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
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
                          await showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 150,
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await pickImage(gallery: true);
                                        await getCurrentPosition();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                                        child: const Center(
                                          child: Text(
                                            'Pick Image from Gallery',
                                            style: TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await pickImage(gallery: false);
                                        await getCurrentPosition();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(color: appThemeBlue, borderRadius: BorderRadius.circular(8)),
                                        child: const Center(
                                          child: Text(
                                            'Pick Image from Camera',
                                            style: TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                );
                              });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 35,
                          color: appThemeBlue,
                          child: const Center(
                            child: Text(
                              'Click Photo',
                              style: TextStyle(color: Colors.white, fontSize: 18),
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
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
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Location",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: loading
                        ? Container(height: 180, width: double.infinity, alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black, width: 0.5)), child: const Center(child: CircularProgressIndicator()))
                        : currentAddress.isEmpty
                            ? Container(
                                height: 180,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black, width: 0.5)),
                                child: const Text(
                                  "No Location found!",
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              )
                            : Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black, width: 0.5)),
                                child: GoogleMap(
                                  mapType: MapType.hybrid,
                                  initialCameraPosition: kGooglePlex,
                                  myLocationEnabled: true,
                                  markers: Set<Marker>.of(markers),
                                  onMapCreated: (GoogleMapController controller) {
                                    googleMapController.complete(controller);
                                  },
                                ),
                              ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    "Address",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextField(
                  style: const TextStyle(height: 1.7, color: Colors.black),
                  maxLines: 1,
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Ahmedabad,Gujarat',
                    fillColor: colorTextField,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    onTap: () async {
                      if (profileImagePath.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Please choose a photo first."),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (currentAddress.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops!, Your location not found."),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        String status = await getAttendanceValue();
                        await controller.addAttendanceHistory(context: context, address: currentAddress, profileImage: base64ImagePath, status: status, place: place!);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: appThemeGreen, borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
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