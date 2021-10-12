import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/taskCard.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/models/ProjectDetailsModel.dart';

class TaskCard extends StatefulWidget {
  TaskCard(this.tasks, {Key? key}) : super(key: key);
  final List<Task>? tasks;
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
          children: List.generate(widget.tasks!.length, (index) {
            return TaskCardWidget(widget.tasks![index]);
          }),
        ),
      ),
    );
  }
}
