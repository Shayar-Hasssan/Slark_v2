import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/screens/chooseWs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(this.userid, {Key? key}) : super(key: key);
  final String userid;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bloc.f_showallworkspaces(context, widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(
          seconds: 3,
        ),
        () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ChooseWs()))
            });
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 475, 0, 0),
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Please wait a moment..',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(20.0),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
