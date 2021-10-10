import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Workspaces extends StatefulWidget {
  const Workspaces({Key? key}) : super(key: key);

  @override
  _WorkspacesState createState() => _WorkspacesState();
}

class _WorkspacesState extends State<Workspaces> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(60.0),
      width: ScreenUtil().setWidth(75.0),
      decoration: BoxDecoration(
        // color: Color(0xff4d3a58).withOpacity(0.1),
        color: Colors.transparent,
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
          onPressed: () {
            print('Helllo');
          },
          child: CircleAvatar(
            child: Image(image: AssetImage('assets/images/profile.png')),
            radius: 100,
            backgroundColor: Colors.blue,
          )),
    );
  }
}
