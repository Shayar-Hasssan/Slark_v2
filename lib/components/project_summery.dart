import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/modalChat.dart';
import 'package:slark_v2/screens/Kanbanboard.dart';
import 'package:slark_v2/screens/gantt.dart';
import 'package:slark_v2/screens/ganttchart.dart';
import 'package:slark_v2/screens/mail.dart';
import 'package:slark_v2/screens/projectOverview.dart';

import '../constraints.dart';

class ProjectSummery extends StatefulWidget {
  const ProjectSummery({Key? key}) : super(key: key);

  @override
  _ProjectSummeryState createState() => _ProjectSummeryState();
}

class _ProjectSummeryState extends State<ProjectSummery> {
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
                      'Slark Project',
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
                            "90%",
                            style: GoogleFonts.poppins(
                              color: Color(0xff4d3a58),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.0),
                            ),
                          ),
                          LinearProgressIndicator(
                            value: 0.9,
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
                          "1 d",
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
                            Navigator.pop(context);
                            //TODO
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModalChat(),
                              ),
                            );
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
                        icon: Icon(Icons.more_horiz, color: Colors.white),
                      ),
                      // IconButton(
                      //   onPressed: () {

                      //   },
                      //   icon: Icon(
                      //     Icons.more_horiz,
                      //     size: ScreenUtil().setHeight(24.0),
                      //   ),
                      //   color: Colors.white,
                      // ),
                    ],
                  ),
                ),
                Expanded(child: SheetView()),
              ],
            ),
          );
        });
  }
}
