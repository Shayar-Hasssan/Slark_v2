import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/chatScreen.dart';
import 'package:slark_v2/components/modalChat.dart';
import 'package:slark_v2/components/newProject.dart';
import 'package:slark_v2/components/newSpace.dart';
import 'package:slark_v2/components/newTeamDialog.dart';
import 'package:slark_v2/components/newWorkspaceDialog.dart';
import 'package:slark_v2/components/project_summery.dart';
import 'package:slark_v2/components/spaces.dart';
import 'package:slark_v2/constraints.dart';
import 'package:slark_v2/models/HomeModel.dart';
import 'package:slark_v2/screens/mail.dart';
import 'package:slark_v2/screens/projects.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(this.workspaceid, this.spaceid, this.userid, {Key? key})
      : super(key: key);
  final String workspaceid;
  final String spaceid;
  final String userid;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool hasNotification = true;
  bool hasMsg = true;
  String chosenSpace = '';
  double xoffset = 0;
  double yoffset = 0;
  List<String> createNew = ['Workspace', 'Space', 'Project', 'Team'];
  List<Space> spaces1 = [];

  bool isDrawerOpen = false;
  @override
  void initState() {
    bloc.f_showHome(context, widget.userid, widget.workspaceid, widget.spaceid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0.0),
      duration: Duration(milliseconds: 200),
      child: Scaffold(
        backgroundColor: Color(0xfff6f7ef),
        body: StreamBuilder<HomeModel>(
            stream: bloc.HomeModelStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                spaces1 = snapshot.data!.data!.first.spaces!;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(10.0),
                            ) +
                            EdgeInsets.only(
                              top: ScreenUtil().setHeight(50.0),
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        xoffset = 0;
                                        yoffset = 0;
                                        isDrawerOpen = false;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                        ),
                                      ),
                                    ),
                                  )

                                //Image pressed to go to profile
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        xoffset = 240;
                                        yoffset = 90;
                                        isDrawerOpen = true;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image(
                                          height: 40.0,
                                          width: 40.0,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/user.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //Notification
                                // ignore: deprecated_member_use
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      hasNotification = !hasNotification;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Icons.notifications_none,
                                        color: kPrimaryColor,
                                        size: ScreenUtil().setHeight(30.0),
                                      ),
                                      Visibility(
                                        visible: hasNotification,
                                        child: Positioned(
                                          right: 2,
                                          top: 3,
                                          child: Container(
                                            height:
                                                ScreenUtil().setHeight(10.0),
                                            width: ScreenUtil().setWidth(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color(0xffedefdf))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //New Project/Space
                                PopupMenuButton(
                                  icon: Icon(Icons.add),
                                  itemBuilder: (context) {
                                    return createNew.map((option) {
                                      return PopupMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (option) {
                                    print(option);
                                    if (option == 'Workspace') {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              NewWS(widget.userid));
                                    } else if (option == 'Space') {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              NewSpace(widget.workspaceid));
                                    } else if (option == 'Project') {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              NewProject(widget.workspaceid,
                                                  widget.spaceid));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              NewTeam());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(40.0),
                      ),
                      //Spaces
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: deprecated_member_use
                            Text(
                              'Space Name',
                              style: GoogleFonts.poppins(
                                color: Color(0xff4d3a58),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(14.0),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                print('Space');
                                showSheet();
                              },
                              icon: Icon(
                                Icons.arrow_right,
                                color: Color(0xff4d3a58),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
                      ),
                      //Search
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(50.0),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: ScreenUtil().setWidth(15.0),
                      //       vertical: ScreenUtil().setHeight(2.0),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.search,
                      //           color: Colors.grey,
                      //           size: ScreenUtil().setHeight(20.0),
                      //         ),
                      //         SizedBox(
                      //           width: ScreenUtil().setWidth(10.0),
                      //         ),
                      //         Expanded(
                      //           child: TextField(
                      //             cursorColor: kPrimaryColor,
                      //             style: GoogleFonts.poppins(
                      //                 decoration: TextDecoration.none,
                      //                 fontSize: ScreenUtil().setSp(14.0),
                      //                 color: Colors.black),
                      //             decoration: InputDecoration(
                      //               hintStyle: TextStyle(
                      //                   fontSize: ScreenUtil().setSp(14.0),
                      //                   color: Colors.grey),
                      //               hintText: 'Search',
                      //               border: InputBorder.none,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: ScreenUtil().setHeight(20.0),
                      ),
                      //Recent Chats
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15.0),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Recent Chats",
                              style: GoogleFonts.poppins(
                                color: Color(0xff4d3a58),
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(18.0),
                              ),
                            ),
                            Spacer(),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MailScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "See all",
                                style: GoogleFonts.poppins(
                                  color: kPrimaryColor,
                                  fontSize: ScreenUtil().setSp(12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20.0),
                        ),
                        child: Wrap(
                          // spacing: 20.0,
                          children: [
                            for (int i = 0;
                                i <
                                    snapshot
                                        .data!.data!.first.recentChat!.length;
                                i++)
                              Stack(
                                children: [
                                  Container(
                                    height: ScreenUtil().setHeight(50.0),
                                    width: ScreenUtil().setWidth(60.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xff4d3a58).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    // ignore: deprecated_member_use
                                    child: InkWell(
                                      onTap: () {
                                        print('Helllo');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage:
                                            AssetImage('assets/images/u1.jpg'),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Positioned(
                                      right: 1,
                                      top: 2,
                                      child: Container(
                                        height: ScreenUtil().setHeight(10.0),
                                        width: ScreenUtil().setWidth(10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30.0),
                      ),
                      //Projects
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(20.0),
                                    ) +
                                    EdgeInsets.only(
                                        top: ScreenUtil().setHeight(20.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      "Active Projects",
                                      style: GoogleFonts.poppins(
                                        color: Color(0xff4d3a58),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(18.0),
                                      ),
                                    ),
                                    Spacer(),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      onPressed: () {
                                        var title = 'All Projects';
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProjectsScreen(title: title)),
                                        );
                                      },
                                      child: Text(
                                        "See all",
                                        style: GoogleFonts.poppins(
                                          color: kPrimaryColor,
                                          fontSize: ScreenUtil().setSp(12.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10.0),
                              ),
                              Expanded(
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: List.generate(
                                        snapshot.data!.data!.first.projects!
                                            .length, (index) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                ScreenUtil().setHeight(10.0),
                                          ),
                                          ProjectSummery(snapshot.data!.data!
                                              .first.projects![index]),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

//chat
  void openBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return ModalChat();
        });
  }

//Spaces
  Future showSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: SnapSpec(
            initialSnap: 0.7,
            snappings: [0.4, 0.7, 1],
          ),
          builder: buildSheet,
        ),
      );
  Widget buildSheet(context, state) => Material(
          child: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 2.0, bottom: 8.0),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 8.0, right: 8.0, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Spaces',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Hi');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 7.0),
                    ),
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      color: Colors.blue,
                      elevation: 0.0,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                NewSpace(widget.workspaceid));
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        'New',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Spaces(this.spaces1),
            ),
          ),
        ],
      ));
}
