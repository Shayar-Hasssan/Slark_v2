import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/deleteDialog.dart';
import 'package:slark_v2/components/memberImage.dart';
import 'package:slark_v2/components/newTeamDialog.dart';
import 'package:slark_v2/components/newWorkspaceDialog.dart';
import 'package:slark_v2/components/workspaces.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/screens/dashboard.dart';
import 'package:slark_v2/screens/mail.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'newMember.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen(this.workspaceid, this.spaceid, this.userid, {Key? key})
      : super(key: key);
  final String workspaceid;
  final String spaceid;
  final String userid;
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
                        'assets/images/user.png',
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
                onTap: () {
                  showTeamsSheet();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: Text(
                  'Dashboard',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(14.0),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
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
                onTap: () {
                  showWorkspaceSheet();
                },
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

  void showTeamsSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: SnapSpec(
            initialSnap: 0.7,
            snappings: [0.8, 0.7, 1],
          ),
          builder: buildTeamsSheet,
        ),
      );

  Widget buildTeamsSheet(context, state) => Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 2.0, bottom: 8.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Teams',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  NewTeam(widget.workspaceid));
                        },
                        elevation: 0.0,
                        backgroundColor: Colors.blue[300],
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: kPrimaryColor,
                indent: 30,
                endIndent: 30.0,
              ),
              SizedBox(height: 15.0),
              Text(
                'Team Name',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Wrap(
                spacing: 5.0,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle5.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle13.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle20.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle26.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle18.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle11.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 15.0),
              Text(
                'Team Name',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Wrap(
                spacing: 5.0,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle5.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle13.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle20.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle26.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle18.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        MemberImg(
                          image: 'assets/images/People_Circle11.png',
                        ),
                        Text('Member Name', style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void showWorkspaceSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: SnapSpec(
            initialSnap: 0.7,
            snappings: [0.8, 0.7, 1],
          ),
          builder: buildWorkspaceSheet,
        ),
      );

  Widget buildWorkspaceSheet(context, state) => Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 2.0, bottom: 8.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wokrspaces',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        NewMember());
                              },
                              icon: Icon(
                                Icons.person_add,
                                color: kPrimaryColor,
                              )),
                          SizedBox(
                            width: 8.0,
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: FloatingActionButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        NewWS(widget.userid));
                              },
                              elevation: 0.0,
                              backgroundColor: textColor,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: kPrimaryColor,
                indent: 30,
                endIndent: 30.0,
              ),
              SizedBox(height: 15.0),
              Wrap(
                spacing: 5.0,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Workspaces(),
                            Text('Workspace', style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ),
                      Positioned(
                        right: -9,
                        top: -15,
                        child: IconButton(
                            icon: Icon(Icons.minimize, color: Colors.red[800]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteDialogue());
                            }),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Workspaces(),
                            Text('Workspace', style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ),
                      Positioned(
                        right: -9,
                        top: -15,
                        child: IconButton(
                            icon: Icon(Icons.minimize, color: Colors.red[800]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteDialogue());
                            }),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Workspaces(),
                            Text('Workspace', style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ),
                      Positioned(
                        right: -9,
                        top: -15,
                        child: IconButton(
                            icon: Icon(Icons.minimize, color: Colors.red[800]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteDialogue());
                            }),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Workspaces(),
                            Text('Workspace', style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ),
                      Positioned(
                        right: -9,
                        top: -15,
                        child: IconButton(
                            icon: Icon(Icons.minimize, color: Colors.red[800]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteDialogue());
                            }),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Workspaces(),
                            Text('Workspace', style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ),
                      Positioned(
                        right: -9,
                        top: -15,
                        child: IconButton(
                            icon: Icon(Icons.minimize, color: Colors.red[800]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteDialogue());
                            }),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Workspaces(),
                            Text('Workspace', style: TextStyle(fontSize: 12.0))
                          ],
                        ),
                      ),
                      Positioned(
                        right: -9,
                        top: -15,
                        child: IconButton(
                            icon: Icon(Icons.minimize, color: Colors.red[800]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteDialogue());
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
