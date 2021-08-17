import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/mail.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 10, bottom: 70),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Shayar Hassan',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(12.0),
                  ),
                ),
                subtitle: Text(
                  'shayar.hassan.m@gmail.com',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(8.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.chat_bubble,
                  color: Colors.white,
                ),
                title: Text(
                  'Chats',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(14.0),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MailScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                title: Text(
                  'Teams',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(14.0),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.workspaces,
                  color: Colors.white,
                ),
                title: Text(
                  'Workspace',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(14.0),
                  ),
                ),
                subtitle: Text(
                  'workspace name',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(8.0),
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 40.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white.withOpacity(0.7),
                ),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(12.0),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
