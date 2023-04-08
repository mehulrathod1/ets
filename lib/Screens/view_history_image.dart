import 'package:etsemployee/Controller/EmployeeController/employee_image_controller.dart';
import 'package:etsemployee/Models/EmployeeModel/employee_view_image.dart';
import 'package:etsemployee/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewHistoryImage extends StatefulWidget {
  const ViewHistoryImage({Key? key}) : super(key: key);

  @override
  State<ViewHistoryImage> createState() => _ViewHistoryImageState();
}

class _ViewHistoryImageState extends State<ViewHistoryImage> {
  bool loading = false;
  EmployeeImage imageController = EmployeeImage();
  late EmployeeViewImageModel imageModel;
  List<ImageList> imageList = [];

  @override
  void initState() {
    initialize(context);
    super.initState();
  }

  Future initialize(BuildContext context) async {
    loading = true;
    await imageController.getEmployeeImage(context).then((value) {
      setState(() {
        imageModel = value;
        imageList = imageModel.data.imageList;
        loading = false;
        debugPrint(value.message);
        debugPrint(imageList.length as String?);
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
          child: Text("View Image", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          var detail = imageList[index];
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
                                    SizedBox(
                                      height: 180,
                                      width: double.infinity,
                                      child: Image.asset(
                                        'assets/man.jpeg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            detail.inTime,
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Email: ",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "crazycoder0009@gmail.com",
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
                                                "Office/House No: ",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "9898989898",
                                                style: TextStyle(fontSize: 14, color: colorTextGray),
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
