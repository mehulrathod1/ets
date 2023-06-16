import 'package:etsemployee/Controller/CompanyController/company_view_map_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_view_map_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Network/api_constant.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';

class ViewAttendanceLocation extends StatefulWidget {
  ViewAttendanceLocation({required this.id, required this.date, Key? key})
      : super(key: key);

  String id;
  String date;

  @override
  State<ViewAttendanceLocation> createState() => _ViewAttendanceLocationState();
}

class _ViewAttendanceLocationState extends State<ViewAttendanceLocation> {
  bool loading = false;
  late CompanyViewMapModel mapModel;
  CompanyMapController mapController = CompanyMapController();
  List<MapList> mapList = [];

  late GoogleMapController mapController1;

  @override
  void initState() {
    initialize(context);

    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await mapController.getMap(context, widget.id, widget.date).then((value) {
      setState(() {
        if (value != null) {
          mapModel = value;
          mapList = mapModel.data.mapList;
          loading = false;
        } else {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No Attendance map found'),
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
          child: Text("Location",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mapList.length,
                        itemBuilder: (context, index) {
                          var detail = mapList[index];

                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: appThemeGreen),
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(2, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Date: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                widget.date,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Status: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                detail!.statusIn.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Time Zone: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                detail!.timezoneName.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Time: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                detail!.inTime.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Address: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  detail!.addressIn.toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: colorTextGray),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            child: SizedBox(
                                              height: 180,
                                              width: double.infinity,
                                              child: GoogleMap(
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                      double.tryParse(
                                                          detail.inLat)!,
                                                      double.tryParse(
                                                          detail.inLong)!),
                                                  zoom: 15,
                                                ),
                                                onMapCreated: (controller) {
                                                  setState(() {
                                                    mapController1 = controller;
                                                  });
                                                },
                                                markers: {
                                                  Marker(
                                                    markerId:
                                                        MarkerId('location'),
                                                    position: LatLng(
                                                        double.tryParse(
                                                            detail.inLat)!,
                                                        double.tryParse(
                                                            detail.inLong)!),
                                                  ),
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    detail.statusOut.isEmpty
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Date: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      widget.date,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Status: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      detail.statusOut
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Time Zone: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      detail.timezoneName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Time: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      detail!.outTime
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: colorTextGray),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Address: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        detail!.addressOut
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                colorTextGray),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                  child: SizedBox(
                                                    height: 180,
                                                    width: double.infinity,
                                                    child: GoogleMap(
                                                      initialCameraPosition:
                                                          CameraPosition(
                                                        target: LatLng(
                                                            double.tryParse(
                                                                detail.outLat)!,
                                                            double.tryParse(
                                                                detail
                                                                    .outLong)!),
                                                        zoom: 15,
                                                      ),
                                                      onMapCreated:
                                                          (controller) {
                                                        setState(() {
                                                          mapController1 =
                                                              controller;
                                                        });
                                                      },
                                                      markers: {
                                                        Marker(
                                                          markerId: MarkerId(
                                                              'location'),
                                                          position: LatLng(
                                                              double.tryParse(
                                                                  detail
                                                                      .outLat)!,
                                                              double.tryParse(
                                                                  detail
                                                                      .outLong)!),
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
        ),
      ),
    );
  }
}
