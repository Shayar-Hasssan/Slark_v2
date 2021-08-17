import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spaces extends StatefulWidget {
  const Spaces({Key? key}) : super(key: key);

  @override
  _SpacesState createState() => _SpacesState();
}

class _SpacesState extends State<Spaces> {
  var spaces = ['spaceyy', 'space n', 'space jk', 'space bm'];
  @override
  Widget build(BuildContext context) =>
      spaces.isEmpty ? Text('NO Spaces Yet') : spaceWid(spaces);

  Widget spaceWid(List spaces) {
    if (spaces.length > 0) {
      for (var space in spaces) {
        return spaceList(space);
      }
    }
    return Text('Spaces');
  }

  spaceList(space) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(30.0),
        right: ScreenUtil().setWidth(30.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: ListTile(
          title: Text('$space'),
          subtitle: Text('3 Projects'),
        ),
      ),
    );
  }
}
