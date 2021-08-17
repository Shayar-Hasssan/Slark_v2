import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreMembers extends StatefulWidget {
  const MoreMembers({Key? key}) : super(key: key);

  @override
  _MoreMembersState createState() => _MoreMembersState();
}

class _MoreMembersState extends State<MoreMembers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(50.0),
      width: ScreenUtil().setWidth(50.0),
      decoration: BoxDecoration(
        color: Color(0xff4d3a58).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
