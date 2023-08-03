import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Controller/CompanyController/compay_employee_live_location_controller.dart';
import '../../Models/CompanyModels/get_employee_live_location.dart';
import '../../Network/api_constant.dart';
import '../../utils/Colors.dart';

class EmployeeLiveLocation extends StatefulWidget {
  EmployeeLiveLocation({required this.employeeId, Key? key}) : super(key: key);
  String employeeId;

  @override
  State<EmployeeLiveLocation> createState() => _EmployeeLiveLocationState();
}

class _EmployeeLiveLocationState extends State<EmployeeLiveLocation> {
  bool loading = false;
  String? currentAddress;
  Position? currentPosition;
  List<Marker> markers = <Marker>[];
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  static const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  CompanyEmployeeLiveLocationController employeeLiveLocationController =
      CompanyEmployeeLiveLocationController();
  late GetEmployeeLiveLocation employeeLiveLocation;

  late GoogleMapController mapController1;
  String message = "";
  String location = "";

  @override
  void initState() {
    getCurrentPosition();
    getEmployeeLiveLocation(context);
    super.initState();
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

  Future<void> getCurrentPosition() async {
    loading = true;
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
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await googleMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      // await getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future getEmployeeLiveLocation(BuildContext context) async {
    await employeeLiveLocationController
        .liveLocation(context, widget.employeeId)
        .then((value) {
      setState(() {
        if (value != null) {
          employeeLiveLocation = value;
          print(employeeLiveLocation.data.location);
          print(widget.employeeId);
          message = employeeLiveLocation.data.status.msg;
          location = employeeLiveLocation.data.location;
        } else {
          loading = false;
          print('employeeLiveLocation.data.location');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No data found'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Live-Location",
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
                    backgroundImage: NetworkImage(ApiConstant.profileImage),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              location,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 570,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appThemeGreen)),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 570,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.tryParse(employeeLiveLocation.data.lat)!,
                                double.tryParse(
                                    employeeLiveLocation.data.long)!),
                            zoom: 15,
                          ),
                          onMapCreated: (controller) {
                            setState(() {
                              mapController1 = controller;
                            });
                          },
                          markers: {
                            Marker(
                              markerId: MarkerId('location'),
                              position: LatLng(
                                  double.tryParse(
                                      employeeLiveLocation.data.lat)!,
                                  double.tryParse(
                                      employeeLiveLocation.data.long)!),
                            ),
                          },
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
