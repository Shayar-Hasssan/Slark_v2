import 'package:flutter/material.dart';
import 'package:slark_v2/constraints.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  final String title;
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      centerTitle: true,
      title: Column(
        children: [
          SizedBox(height: 33.0),
          Text('${widget.title}'),
        ],
      ),
    );
  }
}
