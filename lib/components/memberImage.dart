import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberImg extends StatefulWidget {
  const MemberImg({Key? key, this.image}) : super(key: key);

  @override
  _MemberImgState createState() => _MemberImgState();
  final image;
}

class _MemberImgState extends State<MemberImg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(50.0),
      width: ScreenUtil().setWidth(60.0),
      decoration: BoxDecoration(
        color: Color(0xff4d3a58).withOpacity(0.1),
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          print('Helllo');
        },
        child: Image(
          height: 30.0,
          width: 30.0,
          fit: BoxFit.cover,
          image: AssetImage(widget.image),
        ),
      ),
    );
  }
}
