import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/taskSummery.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key, required this.title}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
  final String title;
}

class _TasksScreenState extends State<TasksScreen> {
  List<String> options = [
    'All Tasks',
    'Critical Tasks',
    'Completed Tasks',
  ];
  var selectedOption;
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
                            "${widget.title}",
                            style: GoogleFonts.poppins(
                              color: Color(0xff4d3a58),
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(18.0),
                            ),
                          ),
                          Spacer(),
                          // ignore: deprecated_member_use
                          PopupMenuButton(
                              color: Colors.blue[50],
                              iconSize: 15,
                              itemBuilder: (context) {
                                return options.map((option) {
                                  return PopupMenuItem(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList();
                              },
                              onSelected: (option) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TasksScreen(title: option.toString()),
                                  ),
                                );
                              }),
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
                            TaskSummery(),
                            SizedBox(
                              height: ScreenUtil().setHeight(5.0),
                            ),
                            Divider(),
                            SizedBox(
                              height: ScreenUtil().setHeight(5.0),
                            ),
                            TaskSummery(),
                            SizedBox(
                              height: ScreenUtil().setHeight(10.0),
                            ),
                            TaskSummery(),
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
