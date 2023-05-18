// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:etsemployee/Controller/EmployeeController/employee_share_location_controller.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({Key? key}) : super(key: key);


  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  bool loading = false;
  bool startLocation = false;
  bool stopLocation = false;
  EmployeeShareLocationController employeeShareLocationController = EmployeeShareLocationController();
  String? currentAddress;
  Position? currentPosition;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
  static const CameraPosition kGooglePlex = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Future<void> getCurrentPosition() async {
    loading = true;
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      setState(() {
        currentPosition = position;
        markers.add(Marker(markerId: const MarkerId('Id'), position: LatLng(position.latitude, position.longitude), infoWindow: const InfoWindow(title: 'My Current Location')));
        loading = false;
      });
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await googleMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      await getAddressFromLatLng(currentPosition!);
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
      Placemark place = placemarks[0];
      setState(() {
        currentAddress = '${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.locality}, ${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.country}';
        startLocation = true;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                style: const TextStyle(fontSize: 18, color: Colors.black),
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
                  contentPadding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 1.0), borderRadius: BorderRadius.circular(7)),
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
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 480,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: appThemeGreen)
                      ),
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (stopLocation == true && currentAddress!.isNotEmpty) {
                        await employeeShareLocationController.stopShareLocation(context, currentAddress!).then((value) => {
                              setState(() {
                                if (value == true) {
                                  startLocation = true;
                                  stopLocation = false;
                                }
                              }),
                            });
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: stopLocation ? appThemelightPink : appThemelightPink.withOpacity(0.5)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Stop Sharing",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (startLocation == true && currentAddress!.isNotEmpty) {
                        await employeeShareLocationController.startShareLocation(context, currentAddress!).then((value) => {
                              setState(() {
                                if (value == true) {
                                  startLocation = false;
                                  stopLocation = true;
                                }
                              }),
                            });
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: startLocation ? appThemeGreen : appThemeGreen.withOpacity(0.50)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Start Sharing", style: TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
