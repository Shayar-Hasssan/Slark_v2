import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/constraints.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue[200],
        elevation: 1.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        // ignore: deprecated_member_use
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 70.0, left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Authentication',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(20.0),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15.0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20.0)),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.date_range_outlined,
                            color: kPrimaryColor,
                            size: ScreenUtil().setHeight(20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15.0),
                      ),
                      Text(
                        "Sep 25, at 11:00 AM",
                        style: GoogleFonts.poppins(
                          color: Color(0xff4d3a58),
                          fontSize: ScreenUtil().setSp(14.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15.0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                            size: ScreenUtil().setHeight(23.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15.0),
                      ),
                      Text(
                        "Member: member Name",
                        style: GoogleFonts.poppins(
                          color: Color(0xff4d3a58),
                          fontSize: ScreenUtil().setSp(14.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15.0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.timeline,
                            color: kPrimaryColor,
                            size: ScreenUtil().setHeight(23.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(35.0),
                      ),
                      Text(
                        "Progress 60%",
                        style: GoogleFonts.poppins(
                          color: Color(0xff4d3a58),
                          fontSize: ScreenUtil().setSp(14.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Container(
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      elevation: 0.0,
                      color: Colors.blue[200],
                      onPressed: () {},
                      icon: Icon(
                        Icons.done,
                        color: Colors.grey,
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
                ),
              ],
            ),
          ),
        ));
  }
}
