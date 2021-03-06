import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/login_form.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/Kanbanboard.dart';
import 'package:slark_v2/screens/auth.dart';
import 'package:slark_v2/screens/chooseWs.dart';
import 'package:slark_v2/screens/gantt.dart';
import 'package:slark_v2/screens/ganttchart.dart';
import 'package:slark_v2/screens/home.dart';
import 'package:slark_v2/screens/mail.dart';
import 'package:slark_v2/screens/mainScreen.dart';
import 'package:slark_v2/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 750),
      builder: () => MaterialApp(
        title: 'Slark',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        home: AuthScreen(),
      ),
    );
  }
}
