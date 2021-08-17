import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constraints.dart';

class ModalChat extends StatelessWidget {
  const ModalChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 800.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          'assets/images/profile.png',
                          height: 60.0,
                          width: 60.0,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Jack Dean',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(16.0),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.delete_outline,
                                color: kPrimaryColor,
                              ),
                              Icon(
                                Icons.more_vert,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Hello, please check your new task!',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(18.0),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "For information on the generic Dart part of this file, see the following page: https://dart.dev/tools/pub/pubspec",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(18.0),
                ),
              ),
              SizedBox(height: 15.0),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.blue[50],
              //     borderRadius: BorderRadius.circular(30.0),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Row(children: [
              //       TextField(
              //         decoration: InputDecoration(
              //           hintText: 'Reply ... ',
              //           hintStyle: GoogleFonts.poppins(
              //             color: Colors.black,
              //             fontSize: ScreenUtil().setSp(12.0),
              //           ),
              //         ),
              //       ),
              //     ]),
              //   ),
              // )

              Wrap(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 1.0),
                        hintText: 'Type a message',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(12.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      size: 15.0,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
