import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/taskCard.dart';
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
            TaskCardWidget(),
            TaskCardWidget(),
            TaskCardWidget(),
            TaskCardWidget(),
          ],
        ),
      ),
    );
  }
}
