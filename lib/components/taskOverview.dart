import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/memberImage.dart';
import 'package:slark_v2/components/moreMembers.dart';
import 'package:slark_v2/components/tasksCards.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/Kanbanboard.dart';
import 'package:slark_v2/screens/tasks.dart';

class TaskSheetView extends StatefulWidget {
  const TaskSheetView({Key? key}) : super(key: key);

  @override
  _TaskSheetViewState createState() => _TaskSheetViewState();
}

class _TaskSheetViewState extends State<TaskSheetView> {
  bool completedTask = false;
  var markColor = Colors.grey;
  statusColor() {
    if (completedTask == true)
      setState(() {
        markColor = Colors.green;
      });
    else
      setState(() {
        markColor = Colors.grey;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(10.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(30.0),
            ),
            //Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20.0),
              ),
              child: Text(
                'Task Name',
                style: GoogleFonts.poppins(
                  color: Color(0xff4d3a58),
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(26.0),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30.0),
            ),
            //Progress
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'In Progress',
                        style: GoogleFonts.poppins(
                          color: Colors.yellow[700],
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(12.0),
                        ),
                      ),
                      Spacer(),
                      Text(
                        '40%',
                        style: GoogleFonts.poppins(
                          color: Colors.yellow[700],
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(12.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10.0),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: LinearProgressIndicator(
                      value: 0.4,
                      backgroundColor: Colors.grey[300],
                      minHeight: 5.0,
                      valueColor: new AlwaysStoppedAnimation(kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30.0),
            ),
            //Date
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20.0)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.date_range_outlined,
                        color: kPrimaryColor,
                        size: ScreenUtil().setHeight(24.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15.0),
                  ),
                  Text(
                    "Nov 12, at 9:00 AM",
                    style: GoogleFonts.poppins(
                      color: Color(0xff4d3a58),
                      fontSize: ScreenUtil().setSp(14.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(40.0),
            ),
            //Members
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20.0),
              ),
              child: Text(
                "Member Assigned To",
                style: GoogleFonts.poppins(
                  color: Color(0xff4d3a58),
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(18.0),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20.0),
              ),
              child: Wrap(
                spacing: 20.0,
                children: [
                  MemberImg(),
                  Visibility(
                    child: MoreMembers(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20.0),
            ),
            ListTile(
              // ignore: deprecated_member_use
              title: RaisedButton.icon(
                color: Colors.blue[200],
                onPressed: () {
                  setState(() {
                    completedTask = !completedTask;
                    statusColor();
                  });
                },
                icon: Icon(
                  Icons.done,
                  color: markColor,
                  size: 35.0,
                ),
                label: Text(
                  'Mark as Completed',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
