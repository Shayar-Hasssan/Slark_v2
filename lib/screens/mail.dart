import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/components/chatScreen.dart';
import 'package:slark_v2/components/modalChat.dart';
import 'package:slark_v2/components/rounded_input.dart';
import 'package:slark_v2/constraints.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  // bool hasMsgs = true;
  int x = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 30.0, top: 70.0),
                    child: Row(
                      children: [
                        //2:32
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context, MaterialPageRoute);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15.0,
                            color: Colors.blue[50],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Mails',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(26.0),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //number of new messages
                            Text(
                              x > 0
                                  ? 'You have $x new messages'
                                  : "You don't have new messages",
                              style: GoogleFonts.poppins(
                                color: Colors.blue[50],
                                fontSize: ScreenUtil().setSp(14.0),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              showNewChatSheet();
                            },
                            icon: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 70.0),
                  Stack(
                    alignment: Alignment.center,
                    // ignore: deprecated_member_use
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: 70.0,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        child: Container(
                          height: 70.0,
                          width: 330,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        child: Container(
                          height: 95.0,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage:
                                          AssetImage('assets/images/u5.jpg'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text(
                                            'Jack Dean',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ScreenUtil().setSp(16.0),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '9:38 AM',
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize:
                                                  ScreenUtil().setSp(12.0),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(height: 10.0),
                                        Text(
                                          'Hello, please check your new task!',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(13.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Text(
                    'RECENTS',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(16.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '{634 mails}',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(12.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },
              child: Container(
                height: 95.0,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('assets/images/u5.jpg'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  'Jack Dean',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16.0),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '9:38 AM',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(12.0),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10.0),
                              Text(
                                'Hello, please check your new task!',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(13.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },
              child: Container(
                height: 95.0,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('assets/images/u3.jpg'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  'Nwoye Ackachi',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16.0),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '9:38 AM',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(12.0),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10.0),
                              Text(
                                "You'd start working on the new project.",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(13.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },
              child: Container(
                height: 95.0,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('assets/images/u2.jpg'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  'James Poll',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16.0),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '9:38 AM',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(12.0),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10.0),
                              Text(
                                'Will you please check the progress?',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(13.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },
              child: Container(
                height: 95.0,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('assets/images/u1.jpg'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  'Salli MBride',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16.0),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '9:38 AM',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(12.0),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10.0),
                              Text(
                                'Yes, sure I will',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(13.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  void showNewChatSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: SnapSpec(
            initialSnap: 0.7,
            snappings: [0.8, 0.7, 1],
          ),
          builder: buildProjectChatSheet,
        ),
      );

  Widget buildProjectChatSheet(context, state) => Material(
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
                  child: RoundedInput(
                    hint: 'User Name',
                  ),
                ),
              ),
              SizedBox(height: 35.0),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
