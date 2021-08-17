import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/constraints.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 2.0,
        decoration: BoxDecoration(
          // color: Color(0xff4d3a58).withOpacity(0.1),
          border: Border.all(color: Colors.white),
          shape: BoxShape.rectangle,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Card(
                color: Colors.blue[200],
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                // ignore: deprecated_member_use
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 70.0, left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Task Name',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(20.0),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
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
                        height: ScreenUtil().setHeight(30.0),
                      ),
                    ],
                  ),
                )),
            Card(
                color: Colors.blue[200],
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                // ignore: deprecated_member_use
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 70.0, left: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Task Name',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(20.0),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
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
                    ],
                  ),
                )),
            Card(
                color: Colors.blue[200],
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                // ignore: deprecated_member_use
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 70.0, left: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Task Name',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(20.0),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
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
                    ],
                  ),
                )),
            Card(
                color: Colors.blue[200],
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                // ignore: deprecated_member_use
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 70.0, left: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Task Name',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(20.0),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
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
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
