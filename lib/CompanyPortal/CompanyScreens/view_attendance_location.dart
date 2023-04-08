import 'package:etsemployee/Controller/CompanyController/company_view_map_controller.dart';
import 'package:etsemployee/Models/CompanyModels/company_view_map_model.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewAttendanceLocation extends StatefulWidget {
  const ViewAttendanceLocation({Key? key}) : super(key: key);

  @override
  State<ViewAttendanceLocation> createState() => _ViewAttendanceLocationState();
}

class _ViewAttendanceLocationState extends State<ViewAttendanceLocation> {
  bool loading = false;
  late CompanyViewMapModel mapModel;
  CompanyMapController mapController = CompanyMapController();
  List<MapList> mapList = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await mapController.getMap(context).then((value) {
      setState(() {
        mapModel = value;
        mapList = mapModel.data.mapList;
        loading = false;
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
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Location", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/man.jpeg'),
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
                                  border: Border.all(width: 1, color: appThemeGreen),
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
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
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                      child: SizedBox(
                                        height: 180,
                                        width: double.infinity,
                                        child: Image.asset(
                                          'assets/map.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tuesday Jan 03,2023",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Status: ",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "In",
                                                style: TextStyle(fontSize: 14, color: colorTextGray),
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
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "IST",
                                                style: TextStyle(fontSize: 14, color: colorTextGray),
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
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "10:00:00 am",
                                                style: TextStyle(fontSize: 14, color: colorTextGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Address: ",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  detail.addressIn,
                                                  style: TextStyle(fontSize: 14, color: colorTextGray),
                                                ),
                                              ),
                                            ],
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
