import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';

import '../../Controller/CompanyController/company_message_controller.dart';
import '../../Models/CompanyModels/company_message_model.dart';
import '../../Network/api_constant.dart';
import '../../utils/Colors.dart';

class CompanyMessageDashboard extends StatefulWidget {
  CompanyMessageDashboard({required this.employeeId, Key? key})
      : super(key: key);
  String employeeId;

  @override
  State<CompanyMessageDashboard> createState() =>
      _CompanyMessageDashboardState();
}

class _CompanyMessageDashboardState extends State<CompanyMessageDashboard> {
  TextEditingController _messageController = TextEditingController();
  bool loading = false;
  CompanyMessageController messageController = CompanyMessageController();
  late CompanyMessageModel messageModel;
  List<Datum> messageList = [];

  @override
  void initState() {
    // TODO: implement initState
    getMessageList(context);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String message = _messageController.text;
    // Implement your logic to send the message
    print('Sending message: $message');
    // Clear the message input field
    _messageController.clear();
  }

  Future getMessageList(BuildContext context) async {
    loading = true;
    await messageController
        .getMessage(context, widget.employeeId)
        .then((value) {
      setState(() {
        if (value != null) {
          messageModel = value;
          messageList = messageModel.data;
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('found'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          messageList.clear();
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No Message found'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScreenBg,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Center(
          child: Text("Messages",
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
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 500,
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            radius: 28,
                                            backgroundImage:
                                                AssetImage('assets/man.jpeg'),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  'employeeName',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 8.0,
                                                ),
                                                child: Text(
                                                  'message',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  width: 500,
                                  color: colorGreenLight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            radius: 28,
                                            backgroundImage:
                                                AssetImage('assets/man.jpeg'),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  'employeeName',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 8.0,
                                                ),
                                                child: Text(
                                                  'message',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  color: colorScreenBg,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
