import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/modalChat.dart';
import 'package:slark_v2/models/HomeModel.dart';
import 'package:slark_v2/models/chat.dart';
import 'package:slark_v2/screens/Kanbanboard.dart';
import 'package:slark_v2/screens/gantt.dart';
import 'package:slark_v2/screens/ganttchart.dart';
import 'package:slark_v2/screens/mail.dart';
import 'package:slark_v2/screens/projectOverview.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../constraints.dart';

class ProjectSummery extends StatefulWidget {
  const ProjectSummery(this.project, {Key? key}) : super(key: key);
  final dynamic project;
  @override
  _ProjectSummeryState createState() => _ProjectSummeryState();
}

class _ProjectSummeryState extends State<ProjectSummery> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20.0),
      ),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          sheet();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20.0),
              vertical: ScreenUtil().setHeight(20.0),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.project.name ?? "",
                      style: GoogleFonts.poppins(
                        color: Color(0xff4d3a58),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(14.0),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30.0),
                        right: ScreenUtil().setWidth(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project.percentage ?? "" "%",
                            style: GoogleFonts.poppins(
                              color: Color(0xff4d3a58),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.0),
                            ),
                          ),
                          LinearProgressIndicator(
                            value:
                                double.parse(widget.project.percentage) / 100,
                            backgroundColor: Colors.blue[100],
                            minHeight: 5.0,
                            valueColor:
                                new AlwaysStoppedAnimation(kPrimaryColor),
                          ),
                        ],
                      ),
                    )),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10.0),
                          vertical: ScreenUtil().setWidth(5.0),
                        ),
                        child: Text(
                          //  "1d",
                          widget.project.creationDate ?? "",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(8.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.0),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10.0),
                          vertical: ScreenUtil().setWidth(5.0),
                        ),
                        child: Text(
                          "In Progress",
                          style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(10.0)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sheet() {
    List<String> pOptions = ['Chat', 'Ganttchart', 'BoardView'];
    var selectedOption;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            color: Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20.0)) +
                      EdgeInsets.only(top: ScreenUtil().setHeight(50.0)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white54)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: ScreenUtil().setHeight(24.0),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return pOptions.map((option) {
                            return PopupMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList();
                        },
                        onSelected: (option) {
                          setState(() {
                            selectedOption = option;
                          });
                          print(selectedOption);
                          if (option == 'Chat') {
                            showProjectChatSheet();
                          } else if (option == 'Ganttchart') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GanttChartScreen(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KanbanBoard(),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: SheetView(widget.project.id)),
              ],
            ),
          );
        });
  }

  void showProjectChatSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: SnapSpec(
            initialSnap: 0.7,
            snappings: [0.8, 0.7, 1],
          ),
          builder: buildProjectChatSheet,
        ),
      );

  Widget buildProjectChatSheet(context, state) => Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 2.0, bottom: 8.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Project Name',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              Divider(
                color: kPrimaryColor,
                indent: 50,
                endIndent: 50.0,
              ),
              SizedBox(height: 15.0),
              Stack(
                children: <Widget>[
                  Container(
                    height: 340,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        itemCount: messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment:
                                  (messages[index].messageType == "receiver"
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      (messages[index].messageType == "receiver"
                                          ? Colors.grey.shade200
                                          : Colors.blue[200]),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  messages[index].messageContent,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
