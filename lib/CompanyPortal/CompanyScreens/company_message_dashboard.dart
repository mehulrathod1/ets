import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../Controller/CompanyController/company_message_controller.dart';
import '../../Controller/CompanyController/company_send_message_controller.dart';
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

  ScrollController _scrollController = ScrollController();
  Timer? _timer;

  CompanySendMessageController sendMessageController =
      CompanySendMessageController();

  @override
  void initState() {
    // TODO: implement initState
    getMessageList(context);
    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 3);
    _timer = Timer.periodic(oneSecond, (timer) {
      getMessageListEverySec(context);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _sendMessage() {
    sendMessageController.sendMessage(context, widget.employeeId).then(
        (value) => {
              sendMessageController.message.clear(),
              getMessageListWithOutLoader(context)
            });
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

          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('found'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );

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
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      });
    });
  }

  Future getMessageListEverySec(BuildContext context) async {
    await messageController
        .getMessage(context, widget.employeeId)
        .then((value) {
      setState(() {
        if (value != null) {
          messageModel = value;
          messageList = messageModel.data;
        } else {
          messageList.clear();
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

  Future getMessageListWithOutLoader(BuildContext context) async {
    await messageController
        .getMessage(context, widget.employeeId)
        .then((value) {
      setState(() {
        if (value != null) {
          messageModel = value;
          messageList = messageModel.data;
        } else {
          messageList.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No Message found'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
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
                    controller: _scrollController,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          var data = messageList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                data.messageType == 'send'
                                    ?
                                    // SizedBox(height: 8),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colorGreenLight,
                                            border: Border.all(
                                                color: colorGreen, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CircleAvatar(
                                                    radius: 28,
                                                    backgroundImage:
                                                        NetworkImage(data
                                                            .companyProfile),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          data.message,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 8.0,
                                                        ),
                                                        child: Text(
                                                          data.timestamp
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(right: 50.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colorBlueBoxLight,
                                            border: Border.all(
                                                color: colorBoxBlue, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CircleAvatar(
                                                    radius: 28,
                                                    backgroundImage:
                                                        NetworkImage(data
                                                            .employeeProfile),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          data.message,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 8.0,
                                                        ),
                                                        child: Text(
                                                          data.timestamp
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
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
                          controller: sendMessageController.message,
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
