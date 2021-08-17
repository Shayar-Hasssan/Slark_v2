import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/project_summery.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f7ef),
        body: Card(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10.0),
                  ) +
                  EdgeInsets.only(
                    top: ScreenUtil().setHeight(30.0),
                  ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20.0),
                          ) +
                          EdgeInsets.only(top: ScreenUtil().setHeight(20.0)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context, MaterialPageRoute);
                              },
                              icon: Icon(Icons.arrow_left)),
                          Spacer(),
                          Text(
                            "All Projects",
                            style: GoogleFonts.poppins(
                              color: Color(0xff4d3a58),
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(18.0),
                            ),
                          ),
                          Spacer(),
                          // ignore: deprecated_member_use
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_vert))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10.0),
                    ),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(10.0),
                            ),
                            ProjectSummery(),
                            SizedBox(
                              height: ScreenUtil().setHeight(10.0),
                            ),
                            ProjectSummery(),
                            SizedBox(
                              height: ScreenUtil().setHeight(10.0),
                            ),
                            ProjectSummery(),
                            SizedBox(
                              height: ScreenUtil().setHeight(10.0),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
