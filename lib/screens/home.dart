import 'package:flutter/material.dart';
import 'package:slark_v2/components/drawer.dart';
import 'package:slark_v2/screens/mainScreen.dart';

class Home extends StatefulWidget {
  const Home(this.workspaceid, this.spaceid, this.userid, this.Ismanager,
      {Key? key})
      : super(key: key);
  final String workspaceid;
  final String spaceid;
  final String userid;
  final bool Ismanager;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrawerScreen(widget.workspaceid, widget.spaceid, widget.userid),
        MainScreen(widget.workspaceid, widget.spaceid, widget.userid),
      ],
    );
  }
}
